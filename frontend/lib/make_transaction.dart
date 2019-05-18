import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_txn_item.dart';
import 'structs.dart';
import 'backend_integration.dart';
import 'add_parties.dart';
import 'package:fluttertoast/fluttertoast.dart';

//1 - Sales
//2 - Purchase
//3 - Payment
//4 - Receipt

class MakeTxn extends StatefulWidget {
  MakeTxn(this.isNewTxn, this.txnType);
  final bool isNewTxn;
  final int txnType;
  @override
  _MakeTxnState createState() => _MakeTxnState();
}

class _MakeTxnState extends State<MakeTxn> {
  bool isPayingLater;
  DateTime _dateTime;
  DateTime _txnDateTime;
  DateTime _payDateTime;
  String _selectedParty;
  String _selectedGroup;
  TextEditingController _invNumController;
  TextEditingController _remarksController;
  List<String> partyList;
  List<String> group = [];
  int finalTotal;

  @override
  void initState() {
    super.initState();
    isPayingLater = true;
    finalTotal = 0;
    _invNumController = TextEditingController(text: '');
    _remarksController = TextEditingController(text: '');
    allItems.removeRange(0, allItems.length);
    allItems = [assets, stock_list].expand((x) => x).toList();
    if (widget.txnType == 1) {
      partyList = salesParties;
    } else if (widget.txnType == 2) {
      partyList = purchaseParties;
    } else if (widget.txnType == 3) {
      partyList = paymentParties;
    } else if (widget.txnType == 4) {
      partyList = receiptParties;
    } else {
      partyList = salesParties;
    }
    if (txnItems.length > 0) {
      txnItems.removeRange(0, txnItems.length);
    }
  }

  @override
  void dispose() {
    _invNumController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context, bool isTxnDateTime) async {
    _dateTime = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now(),
        context: context,
        initialDatePickerMode: DatePickerMode.day);
    setState(() {
      if (isTxnDateTime == true) {
        _txnDateTime = _dateTime;
      } else {
        _payDateTime = _dateTime;
      }
    });
  }

  void _onPartyChanged(String newParty) {
    setState(() {
      _selectedParty = newParty;
    });
  }

  void _onGroupChanged(String newGroup) {
    setState(() {
      _selectedGroup = newGroup;
    });
  }

  String getDateTimeString(DateTime dateTime) {
    return dateTime != null
        ? (dateTime.day.toString() +
            '-' +
            dateTime.month.toString() +
            '-' +
            dateTime.year.toString())
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Make Transaction'),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Date'),
                        GestureDetector(
                            onTap: () {
                              _selectDate(context, true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              height: 40.0,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(_dateTime == null
                                      ? 'Select Date'
                                      : getDateTimeString(_txnDateTime)),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 100, child: Text('Group*')),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedGroup,
                              items: partyList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                _onGroupChanged(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 100, child: Text('Party Name*')),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedParty,
                              items: widget.txnType == 1
                                  ? customers.map((Party value) {
                                      return DropdownMenuItem<String>(
                                        value: value.name,
                                        child: Text(value.name),
                                      );
                                    }).toList()
                                  : suppliers.map((Party value) {
                                      return DropdownMenuItem<String>(
                                        value: value.name,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                              onChanged: (String value) {
                                _onPartyChanged(value);
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    AddParties(widget.txnType == 1 ? 2 : 1),
                                    null));
                          },
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 100, child: Text('Invoice No.')),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _invNumController,
                              onSaved: (String val) {
                                _invNumController.text = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      height: 200.0,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    BorderDirectional(bottom: BorderSide())),
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              'Items',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: txnItems.length == 0
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                        'No items in this transaction yet.'),
                                  )
                                : getItemsList(),
                          ),
                          Container(
                            height: 25.0,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border:
                                    BorderDirectional(bottom: BorderSide())),
                            child: MaterialButton(
                              child: Text(
                                'Add Item +',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddTxnItem(), null));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '  Pay Now',
                          textAlign: TextAlign.left,
                        ),
                        Switch(
                          inactiveThumbColor: Theme.of(context).primaryColor,
                          value: isPayingLater,
                          onChanged: (bool value) {
                            setState(() {
                              isPayingLater = value;
                            });
                          },
                        ),
                      ],
                    ),
                    isPayingLater == false ? getPaymentWidgets() : Container(),
                    Row(
                      children: <Widget>[
                        Container(width: 100, child: Text('Remarks')),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _remarksController,
                              onSaved: (String val) {
                                _remarksController.text = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    onPressed: () {
                      addTxn();
                    },
                  )),
            ],
          ),
        ));
  }

  getPaymentWidgets() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Pay Date'),
            GestureDetector(
                onTap: () {
                  _selectDate(context, false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 40.0,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(_dateTime == null
                          ? 'Select Date'
                          : getDateTimeString(_payDateTime)),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ))
          ],
        )
      ],
    );
  }

  addTxn() async {
    if (_selectedParty != null &&
        _selectedGroup != null &&
        txnItems.length != 0) {
      try {
        int partyId = (customers.firstWhere(
                (found) => found.name == _selectedParty,
                orElse: () => null))
            ?.partyId;
        if (partyId == null) {
          partyId = (suppliers.firstWhere(
                  (found) => found.name == _selectedParty,
                  orElse: () => null))
              ?.partyId;
        }
        int status = await Future.value(addTxnBE(
                getDateTimeString(_txnDateTime),
                getDateTimeString(_payDateTime),
                partyId,
                _invNumController.text,
                1,
                finalTotal.toString(),
                txnItems.length,
                _remarksController.text,
                widget.txnType,
                _selectedGroup))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        });
        if (status == 1) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } catch (exception) {
        print(exception.toString());
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      Fluttertoast.showToast(msg: "Fill Mandatory Fields!");
    }
  }

  getItemsList() {
    return ListView.builder(
      itemCount: txnItems.length + 1,
      itemBuilder: (BuildContext context, int index) {
        Item item;
        if (index > 0) {
          item = assets.firstWhere(
              (itemFound) => itemFound.itemId == txnItems[index - 1].itemId,
              orElse: () => null);
          if (item == null) {
            item = stock_list.firstWhere(
                (itemFound) => itemFound.itemId == txnItems[index - 1].itemId,
                orElse: () => null);
          }
          finalTotal = finalTotal +
              ((txnItems[index - 1].qty *
                  int.parse(txnItems[index - 1].basePrice)));
        }
        if (index == 0) {
          return Container(
            decoration:
                BoxDecoration(border: BorderDirectional(bottom: BorderSide())),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'Item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Base Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Tax',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  item?.name != null ? item.name : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  txnItems[index - 1].basePrice != null
                      ? txnItems[index - 1].basePrice
                      : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  txnItems[index - 1].qty.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  item?.price != null ? item?.price.toString() : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  txnItems[index - 1].taxPc.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  (txnItems[index - 1].qty *
                          int.parse(txnItems[index - 1].basePrice))
                      .toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
