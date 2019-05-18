import 'package:flutter/material.dart';
import 'add_parties.dart';
import 'navigation.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Suppliers extends StatefulWidget {
  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getParties();
  }

  getParties() async {
    try {
      int status = await Future.value(getPartiesBE(1))
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
          title: Text('Suppliers'),
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
                                      'Add Supplier',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddParties(1), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: suppliers.length == 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'No suppliers have been added yet!'),
                                    )
                                  : getSupplierList())
                        ],
                      );
              }),
        ));
  }

  getSupplierList() {
    print(suppliers.length.toString());
    return ListView.builder(
      itemCount: suppliers.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                suppliers[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(suppliers[index].gstin),
              Text(suppliers[index].addr),
              Text(suppliers[index].mobileNum.toString()),
              Text(suppliers[index].emailId)
            ],
          ),
        );
      },
    );
  }
}
