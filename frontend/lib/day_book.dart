import 'package:flutter/material.dart';

class DayBook extends StatefulWidget {
  @override
  _DayBookState createState() => _DayBookState();
}

class _DayBookState extends State<DayBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day Book'),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
