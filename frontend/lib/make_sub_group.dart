import 'package:flutter/material.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'structs.dart';
import 'make_main_group.dart';
import 'navigation.dart';

class SubMainGroup extends StatefulWidget {
  @override
  _SubMainGroupState createState() => _SubMainGroupState();
}

class _SubMainGroupState extends State<SubMainGroup> {
  TextEditingController _mainGroupController;
  String _selectedMainGroup;

  @override
  void initState() {
    super.initState();
    _mainGroupController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _mainGroupController.dispose();
    super.dispose();
  }

  void _onMainGroupChanged(String newGroup) {
    setState(() {
      _selectedMainGroup = newGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Sub Group'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                  child: TextFormField(
                decoration: const InputDecoration(labelText: 'Name*'),
                keyboardType: TextInputType.text,
                onSaved: (String val) {
                  _mainGroupController.text = val;
                },
                controller: _mainGroupController,
              )),
              Row(
                children: <Widget>[
                  Container(width: 100, child: Text('Main Group*')),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedMainGroup,
                        items: mainGroups.map((MainGroup value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          _onMainGroupChanged(value);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(MakeMainGroup(), null));
                    },
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.bottomRight,
                child: RawMaterialButton(
                  fillColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(side: BorderSide()),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    addMainGroup();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addMainGroup() async {
    if (_mainGroupController.text != '' && _selectedMainGroup != null) {
      try {
        int mainGroupId =
            (mainGroups.firstWhere((found) => found.name == _selectedMainGroup))
                .mgId;
        await Future.value(subGroupBE(mainGroupId, _mainGroupController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((itemid) {
          if (itemid != -1) {
            subGroups.add(
                SubGroup(mainGroupId, mainGroupId, _mainGroupController.text));
            Navigator.pop(context);

            Fluttertoast.showToast(msg: "Sub Group Created");
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      } catch (exception) {
        print(exception.toString());
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      Fluttertoast.showToast(msg: "Fill Mandatory Fields!");
    }
  }
}
