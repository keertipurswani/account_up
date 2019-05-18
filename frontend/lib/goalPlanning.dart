import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_goal.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getEmps();
  }

  getEmps() async {
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
        title: Text('Goal Planning'),
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
                                      'Add Goal',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddGoal(), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child:
          (pendingGoals.length == 0 && finishedGoals.length == 0)
               ? Text(
                    'You have not added any goals yet. Get Started by pressing on add button.',
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                        )
                                      : getGoalsList())),
                        ],
                      );
              })),
    );
  }

   getGoalsList() {
    return ListView.builder(
      itemCount: pendingGoals.length + finishedGoals.length,
      itemBuilder: (BuildContext context, int index) {
        return Container();
      },
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


