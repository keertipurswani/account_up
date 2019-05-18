import 'package:flutter/material.dart';
import 'navigation.dart';
import 'create_company.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'backend_integration.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode eMailFocusNode;
  FocusNode passwordFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    eMailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    eMailFocusNode.dispose();
    passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  focusNode: eMailFocusNode,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  onSaved: (String val) {
                    _emailController.text = val.trim();
                  },
                  onFieldSubmitted: (String val) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  controller: _emailController,
                ),
                TextFormField(
                  focusNode: passwordFocusNode,
                  decoration: const InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  validator: validatePassword,
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
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  setState(() {
                    _autoValidate = true;
                  });
                  createUser();
                }
              },
            )),
      ],
    ));
  }

  createUser() async {
    try {
      bool creationSucc = await Future.value(
              createUserBE(_emailController.text, _passwordController.text))
          .timeout(Duration(seconds: 90), onTimeout: () {
        Fluttertoast.showToast(msg: "Time out occurred");
      });
      if (creationSucc == true) {
        Navigator.push(context, SlideRightRoute(CreateCompany(true), null));
        Fluttertoast.showToast(msg: "User Created");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: exception.toString());
      print(exception);
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

String validatePassword(String password) {
  String trimmedPassword = password.trim();
  if (trimmedPassword.length < 6) {
    return 'The Password must be at least 6 characters.';
  } else if (trimmedPassword.length > 27) {
    return 'The Password can be at most 27 characters.';
  }
  return null;
}
