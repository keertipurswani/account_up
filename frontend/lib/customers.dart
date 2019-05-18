import 'package:flutter/material.dart';
import 'add_parties.dart';
import 'navigation.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getParties();
  }

  getParties() async {
    try {
      int status = await Future.value(getPartiesBE(2))
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
          title: Text('Customers'),
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
                                      'Add Customer',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddParties(2), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: customers.length == 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'No customers have been added yet!'),
                                    )
                                  : getCustomerList())
                        ],
                      );
              }),
        ));
  }

  getCustomerList() {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                customers[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(customers[index].gstin),
              Text(customers[index].addr),
              Text(customers[index].mobileNum.toString()),
              Text(customers[index].emailId)
            ],
          ),
        );
      },
    );
  }
}
