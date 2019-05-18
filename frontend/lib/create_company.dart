import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_parties.dart';
import 'backend_integration.dart';
import 'structs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateCompany extends StatefulWidget {
  CreateCompany(this.isStartOfApp);
  final bool isStartOfApp;
  @override
  _CreateCompanyState createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  FocusNode eMailFocusNode;
  FocusNode passwordFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _nameController;
  TextEditingController _emailIdController;
  TextEditingController _addressController;
  TextEditingController _mobileController;
  TextEditingController _gstinController;

  @override
  void initState() {
    super.initState();
    eMailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    _nameController = TextEditingController(text: '');
    _emailIdController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileController = TextEditingController(text: '');
    _gstinController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    eMailFocusNode.dispose();
    passwordFocusNode.dispose();
    _nameController.dispose();
    _emailIdController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _gstinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Create Company'),
        ),
        body: Center(
            child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Name*'),
                      keyboardType: TextInputType.text,
                      onSaved: (String val) {
                        val = val.trim();
                        val = val[0].toUpperCase() + val.substring(1);
                        _nameController.text = val;
                      },
                      controller: _nameController,
                    ),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Address*'),
                      keyboardType: TextInputType.text,
                      onSaved: (String val) {
                        val = val.trim();
                        val = val[0].toUpperCase() + val.substring(1);
                        _nameController.text = val;
                      },
                      controller: _addressController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'GSTIN*'),
                      keyboardType: TextInputType.text,
                      controller: _gstinController,
                      onSaved: (String val) {
                        _gstinController.text = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Mobile Num'),
                      keyboardType: TextInputType.phone,
                      validator: validateMobile,
                      controller: _mobileController,
                      onSaved: (String val) {
                        _mobileController.text = val;
                      },
                    ),
                    TextFormField(
                      focusNode: eMailFocusNode,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      onSaved: (String val) {
                        _emailIdController.text = val.trim();
                      },
                      onFieldSubmitted: (String val) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      controller: _emailIdController,
                    ),
                  ],
                )),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  onPressed: () {
                    createCompany(widget.isStartOfApp);
                  },
                )),
          ],
        )));
  }

  createCompany(bool isStartOfApp) async {
    if (_nameController.text != '' &&
        _addressController.text != '' &&
        _gstinController.text != '') {
      try {
        await Future.value(createCompanyBE(
                userId,
                _nameController.text,
                _addressController.text,
                _gstinController.text,
                _mobileController.text,
                _emailIdController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((compId) {
          if (compId != -1) {
            if (isStartOfApp == true) {
              presentCompanyId = compId;
            }
            companies.add(Company(
                compId,
                _nameController.text,
                _addressController.text,
                _gstinController.text,
                _mobileController.text != ''
                    ? int.parse(_mobileController.text)
                    : 0,
                _emailIdController.text));
            if (isStartOfApp == true) {
              Navigator.push(context, SlideRightRoute(AddParties(0), null));
            } else {
              Navigator.pop(context);
            }
            Fluttertoast.showToast(msg: "Company Created");
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

String validateEmail(String eMail) {
  String trimmedEMail = eMail.trim();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(trimmedEMail)) {
    return 'Enter Valid Email ID!';
  } else if (trimmedEMail.length > 72) {
    return 'Email ID can be max 72 charaters!';
  } else {
    return null;
  }
}

String validateMobile(String num) {
  String trimmedNum = num.trim();
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(trimmedNum)) {
    return 'Mobile number must have only digits!';
  } else if (trimmedNum.length != 10) {
    return 'Mobile Number must be of 10 digits!';
  } else {
    return null;
  }
}
