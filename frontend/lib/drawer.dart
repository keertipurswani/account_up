import 'package:flutter/material.dart';
import 'account.dart';
import 'contacts.dart';
import 'employees.dart';
import 'gallery.dart';
import 'transactions.dart';
import 'reports.dart';
import 'cmpny_mgmt.dart';
import 'goalPlanning.dart';
import 'navigation.dart';

getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: Text(
          'Hello User',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        )),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Account',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Account(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Invoices',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Transactions(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Reports',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Reports(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Targets and Goal Planning',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(GoalPlanning(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Reminders',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            // Navigator.push(context, SlideRightRoute(CallDetails(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Settings',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(CompanyMgmt(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Gallery',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Gallery(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Employess',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Employees(), null));
          },
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
          isThreeLine: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 25.0,
              ),
              Text(
                '       Tax Filing',
                textAlign: TextAlign.left,
              )
            ],
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(Account(), null));
          },
        ),
      ],
    ),
  );
}
