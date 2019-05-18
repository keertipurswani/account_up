import 'package:flutter/material.dart';
import 'create_company.dart';
import 'navigation.dart';
import 'structs.dart';

class CompanyMgmt extends StatefulWidget {
  @override
  _CompanyMgmtState createState() => _CompanyMgmtState();
}

class _CompanyMgmtState extends State<CompanyMgmt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Company Management'),
        ),
        body: Column(
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
                        'Add Company',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context, SlideRightRoute(CreateCompany(false), null));
                },
              ),
            ),
            Expanded(child: getCompanyList())
          ],
        ));
  }

  getCompanyList() {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                companies[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(companies[index].gstin),
              Text(companies[index].addr),
              Text(companies[index].mobNum.toString()),
              Text(companies[index].emailId)
            ],
          ),
        );
      },
    );
  }
}
