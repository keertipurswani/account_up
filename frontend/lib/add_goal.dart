import 'package:flutter/material.dart';

class AddGoal extends StatefulWidget {
  @override
  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  TextEditingController _subController;
  DateTime _dateTime;
  DateTime _goalDateTime;

  @override
  void initState() {
    super.initState();
    _subController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _subController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    _dateTime = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        context: context,
        initialDatePickerMode: DatePickerMode.day);
    setState(() {
      _goalDateTime = _dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Goal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(border: Border.all()),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: true,
                  controller: _subController,
                  decoration: InputDecoration(labelText: 'Goal'),
                  cursorColor: Theme.of(context).primaryColor,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Aimed Date'),
                  GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        height: 40.0,
                        width: 150,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(_dateTime == null
                                ? 'Select Date'
                                : _goalDateTime.day.toString() +
                                    '/' +
                                    _goalDateTime.month.toString() +
                                    '/' +
                                    _goalDateTime.year.toString()),
                            Spacer(
                              flex: 1,
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(border: Border.all()),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: true,
                  controller: _subController,
                  decoration: InputDecoration(labelText: 'Description'),
                  cursorColor: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ),
    );
  }
}
