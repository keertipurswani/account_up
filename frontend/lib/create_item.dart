import 'package:flutter/material.dart';
import 'navigation.dart';
import 'structs.dart';

class CreateItem extends StatefulWidget {
  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController _nameController;
  TextEditingController _mainGroupController;
  TextEditingController _subGroupController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _selectedUnit;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '');
    _mainGroupController = TextEditingController(text: '');
    _subGroupController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mainGroupController.dispose();
    _subGroupController.dispose();
    super.dispose();
  }

  void _onUnitChanged(String newUnit) {
    setState(() {
      _selectedUnit = newUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Create Item'),
        ),
        body: Center(
            child: Container(
                margin: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            TextFormField(
                              autofocus: true,
                              decoration:
                                  const InputDecoration(labelText: 'Name*'),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _nameController.text = val;
                              },
                              controller: _nameController,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Main Group'),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _mainGroupController.text = val;
                              },
                              controller: _mainGroupController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Sub Group'),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _subGroupController.text = val;
                              },
                              controller: _subGroupController,
                            ),
                            Row(
                              children: <Widget>[
                                Text('Unit'),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _selectedUnit,
                                      items: units.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        _onUnitChanged(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Quantity Available'),
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                val = val.trim();
                                //val =
                                //   val[0].toUpperCase() + val.substring(1);
                                // _subGroupController.text = val;
                              },
                              //controller: _subGroupController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                val = val.trim();
                                //val =
                                //   val[0].toUpperCase() + val.substring(1);
                                // _subGroupController.text = val;
                              },
                              //controller: _subGroupController,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Tax Percent'),
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                val = val.trim();
                                //val =
                                //   val[0].toUpperCase() + val.substring(1);
                                // _subGroupController.text = val;
                              },
                              //controller: _subGroupController,
                            ),
                          ],
                        )),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(10.0),
                      child: RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(20.0),
                        shape: CircleBorder(side: BorderSide()),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ))));
  }
}
