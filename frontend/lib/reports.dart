import 'package:flutter/material.dart';
import 'navigation.dart';
import 'profit_loss.dart';
import 'balance_sheet.dart';
import 'day_book.dart';

class ReportListItem {
  ReportListItem(this.reportName, this.reportPage);
  String reportName;
  Widget reportPage;
}

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List<ReportListItem> reports = [
    ReportListItem("Balance Sheet", BalanceSheet()),
    ReportListItem("Profit and Loss Sheet", ProfitNLoss()),
    ReportListItem("Day Book", DayBook())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
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
                          'Balance Sheet',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(BalanceSheet(), null));
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
                          'Profit And Loss',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(ProfitNLoss(), null));
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
                          'Day Book',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(DayBook(), null));
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
                          'Stock Summary',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      //Navigator.push(
                      //    context, SlideRightRoute(MakeTxn(), null));
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
                          'Ratio Analysis',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                    onPressed: () {
                      //Navigator.push(
                      //    context, SlideRightRoute(MakeTxn(), null));
                    },
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
