import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'login.dart';

class SingUpLogin extends StatefulWidget {
  @override
  _SingUpLoginState createState() => _SingUpLoginState();
}

class _SingUpLoginState extends State<SingUpLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text("Login"),
                ),
                Tab(
                  child: Text("Sign Up"),
                )
              ],
            ),
            title: Text("Account Up"),
            centerTitle: true,
          ),
          body: TabBarView(
            children: <Widget>[Login(), SignUp()],
          ),
        ));
  }
}
