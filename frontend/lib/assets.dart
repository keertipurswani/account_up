import 'package:flutter/material.dart';
import 'add_stock.dart';
import 'navigation.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Assets extends StatefulWidget {
  @override
  _AssetsState createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getItems();
  }

  getItems() async {
    try {
      int status = await Future.value(getItemsBE(1))
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
          title: Text('Assets'),
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
                                      'Add Asset',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddStock(1), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: assets.length == 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'No assets have been added yet!'),
                                    )
                                  : getAssetsList())
                        ],
                      );
              }),
        ));
  }

  getAssetsList() {
    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                assets[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(assets[index].subGroup),
              Text(assets[index].mainGroup),
              Text("Rs " + assets[index].price),
              Text("Unit: " + assets[index].unit)
            ],
          ),
        );
      },
    );
  }
}
