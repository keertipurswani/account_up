import 'package:flutter/material.dart';
import 'drawer.dart';
import 'navigation.dart';
import 'employees.dart';
import 'add_transaction.dart';
import 'reports.dart';
import 'package:account_up/transactions.dart';
import 'goalPlanning.dart';
import 'suppliers.dart';
import 'customers.dart';
import 'cmpny_mgmt.dart';
import 'stock.dart';
import 'assets.dart';
import 'backend_integration.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Up'),
      ),
      drawer: getDrawer(context),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: 60.0,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: 20.0,
                    ),
                    Text(
                      'Employees',
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context, SlideRightRoute(Employees(), null));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: 60.0,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 20.0,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                onTap: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: 60.0,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      size: 20.0,
                    ),
                    Text(
                      'Add Transaction',
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context, SlideRightRoute(AddTxn(), null));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: 60.0,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.receipt,
                      size: 20.0,
                    ),
                    Text(
                      'Reports',
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context, SlideRightRoute(Reports(), null));
                },
              ),
            ),
          ],
        ),
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
                          'Assets',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(Assets(), null));
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
                          'Stock',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(Stock(), null));
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
                          'Goal Planning',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(GoalPlanning(), null));
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
                          'Company Management',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(CompanyMgmt(), null));
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
                          'Suppliers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(Suppliers(), null));
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
                          'Customers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(Customers(), null));
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
                          'Transactions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(Transactions(), null));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
