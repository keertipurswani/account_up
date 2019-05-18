import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_employee.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoalPlanning extends StatefulWidget {
  @override
  _GoalPlanningState createState() => _GoalPlanningState();
}

class _GoalPlanningState extends State<GoalPlanning> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getGoals();
  }

  getGoals() async {
    try {
      int status = await Future.value(getEmpsBE())
          .timeout(Duration(seconds: 90), onTimeout: () {
        print('TIME OUT HAPPENED');
      });
      if (status != 1) {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: 'Check internet connection.');
      print('Error occurred' + exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: Center(
          child: FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : Column(
                        children: <Widget>[
                          Container(
                            child: MaterialButton(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(5.0),
                                color: Colors.black,
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Add Employee',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddEmployee(), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: employees.length == 0
                                      ? Text(
                                          'No employees have been added yet.',
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                        )
                                      : getEmployeeList())),
                        ],
                      );
              })),
    );
  }

  getEmployeeList() {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                employees[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(employees[index].designation),
              Text(employees[index].emailId),
              Text(employees[index].mobNum),
              Text(employees[index].age.toString() + ' Yrs'),
              Text(employees[index].add)
            ],
          ),
        );
      },
    );
  }
}
