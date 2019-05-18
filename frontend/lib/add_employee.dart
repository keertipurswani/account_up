import 'package:flutter/material.dart';
import 'backend_integration.dart';
import 'structs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _nameController;
  TextEditingController _emailIdController;
  TextEditingController _addressController;
  TextEditingController _mobileController;
  TextEditingController _ageController;
  TextEditingController _desigController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '');
    _emailIdController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileController = TextEditingController(text: '');
    _ageController = TextEditingController(text: '');
    _desigController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailIdController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _ageController.dispose();
    _desigController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
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
                              decoration:
                                  const InputDecoration(labelText: 'Design*'),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _desigController.text = val;
                              },
                              controller: _desigController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Address*'),
                              keyboardType: TextInputType.text,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _addressController.text = val;
                              },
                              controller: _addressController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Age'),
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _ageController.text = val;
                              },
                              controller: _ageController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Mobile'),
                              keyboardType: TextInputType.number,
                              onSaved: (String val) {
                                val = val.trim();
                                _mobileController.text = val;
                              },
                              controller: _mobileController,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String val) {
                                val = val.trim();
                                val = val[0].toUpperCase() + val.substring(1);
                                _emailIdController.text = val;
                              },
                              controller: _emailIdController,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 30.0),
            child: RawMaterialButton(
              fillColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(side: BorderSide()),
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                addEmp();
              },
            ),
          )
        ],
      )),
    );
  }

  addEmp() async {
    if (_nameController.text != '' && _addressController.text != '') {
      try {
        await Future.value(addEmpBE(
                _nameController.text,
                _addressController.text,
                _mobileController.text,
                _emailIdController.text,
                _ageController.text,
                _desigController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((empid) {
          if (empid != -1) {
            Fluttertoast.showToast(msg: "Employee Created");
            employees.add(Emp(
                empid,
                _nameController.text,
                _mobileController.text,
                _desigController.text,
                _addressController.text,
                _emailIdController.text,
                _ageController.text != ''
                    ? int.parse(_ageController.text)
                    : 0));
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      } catch (exception) {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      Fluttertoast.showToast(msg: "Fill Mandatory Fields!");
    }
  }
}
