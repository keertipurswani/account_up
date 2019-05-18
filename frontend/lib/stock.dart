import 'package:flutter/material.dart';
import 'add_stock.dart';
import 'navigation.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
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
          title: Text('Stock'),
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
                                      'Add Stock',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddStock(2), null));
                              },
                            ),
                          ),
                          Expanded(
                              child: stock_list.length == 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      child:
                                          Text('No stock has been added yet!'),
                                    )
                                  : getStockList())
                        ],
                      );
              }),
        ));
  }

  getStockList() {
    return ListView.builder(
      itemCount: stock_list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                stock_list[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(stock_list[index].subGroup),
              Text(stock_list[index].mainGroup),
              Text("Rs " + stock_list[index].price),
              Text("Unit: " + stock_list[index].unit)
            ],
          ),
        );
      },
    );
  }
}
