import 'package:flutter/material.dart';
import 'navigation.dart';
import 'make_transaction.dart';

class AddTxn extends StatefulWidget {
  @override
  _AddTxnState createState() => _AddTxnState();
}

class _AddTxnState extends State<AddTxn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Add Transaction'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Sales',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 0), null));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Purchase',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 1), null));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Payment',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 2), null));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Receipt',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 3), null));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Contra',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 4), null));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text(
                            'Journal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(MakeTxn(true, 5), null));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
