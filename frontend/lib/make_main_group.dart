import 'package:flutter/material.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'structs.dart';

class MakeMainGroup extends StatefulWidget {
  @override
  _MakeMainGroupState createState() => _MakeMainGroupState();
}

class _MakeMainGroupState extends State<MakeMainGroup> {
  TextEditingController _mainGroupController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Main Group'),
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
    if (_mainGroupController.text != '') {
      try {
        await Future.value(addMainGroupBE(_mainGroupController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((itemid) {
          if (itemid != -1) {
            mainGroups.add(MainGroup(itemid, _mainGroupController.text));
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Main Group Created");
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
