import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_stock.dart';
import 'backend_integration.dart';
import 'structs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddParties extends StatefulWidget {
  AddParties(this.partyType);
  final int partyType;
  //if start of app - party type is 0
  @override
  _AddPartiesState createState() => _AddPartiesState();
}

class _AddPartiesState extends State<AddParties> {
  bool isAddingSupplier;
  bool isAddingCustomer;
  FocusNode eMailFocusNode;
  FocusNode passwordFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _nameController;
  TextEditingController _emailIdController;
  TextEditingController _addressController;
  TextEditingController _mobileController;
  TextEditingController _gstinController;
  TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    isAddingSupplier = false;
    isAddingCustomer = false;
    if (widget.partyType == 1) {
      isAddingSupplier = true;
    } else if (widget.partyType == 2) {
      isAddingCustomer = true;
    }
    eMailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    _nameController = TextEditingController(text: '');
    _emailIdController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileController = TextEditingController(text: '');
    _gstinController = TextEditingController(text: '');
    _remarksController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    eMailFocusNode.dispose();
    passwordFocusNode.dispose();
    _nameController.dispose();
    _emailIdController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _gstinController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Add Party'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: widget.partyType == 0
                    ? BoxDecoration(border: Border.all())
                    : BoxDecoration(),
                margin: EdgeInsets.all(20.0),
                child: (isAddingSupplier == false && isAddingCustomer == false)
                    ? Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Spacer(
                                  flex: 1,
                                ),
                                RawMaterialButton(
                                  fillColor: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(20.0),
                                  shape: CircleBorder(side: BorderSide()),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isAddingSupplier = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Text('Add Supplier')),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Spacer(
                                  flex: 1,
                                ),
                                RawMaterialButton(
                                  fillColor: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(20.0),
                                  shape: CircleBorder(side: BorderSide()),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isAddingCustomer = true;
                                    });
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Text('Add Customer')),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                          ],
                        ))
                    : Container(
                        margin: EdgeInsets.all(10.0),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              child: Form(
                                key: _formKey,
                                autovalidate: _autoValidate,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          labelText: 'Name*'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _nameController.text = val;
                                      },
                                      controller: _nameController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Address*'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _addressController.text = val;
                                      },
                                      controller: _addressController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'GSTIN*'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _gstinController.text = val;
                                      },
                                      controller: _gstinController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Mobile'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _mobileController.text = val;
                                      },
                                      controller: _mobileController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Email'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _emailIdController.text = val;
                                      },
                                      controller: _emailIdController,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Remarks'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        val = val.trim();
                                        val = val[0].toUpperCase() +
                                            val.substring(1);
                                        _remarksController.text = val;
                                      },
                                      controller: _remarksController,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                            widget.partyType == 0
                                ? Column(
                                    children: <Widget>[
                                      Container(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          RawMaterialButton(
                                            fillColor:
                                                Theme.of(context).primaryColor,
                                            padding: EdgeInsets.all(10.0),
                                            shape: CircleBorder(
                                                side: BorderSide()),
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isAddingSupplier = false;
                                                isAddingCustomer = false;
                                              });
                                            },
                                          ),
                                          RawMaterialButton(
                                            fillColor:
                                                Theme.of(context).primaryColor,
                                            padding: EdgeInsets.all(10.0),
                                            shape: CircleBorder(
                                                side: BorderSide()),
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              addParty();
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Container()
                          ],
                        ))),
          ),
          widget.partyType == 0
              ? Column(
                  children: <Widget>[
                    Container(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(10.0),
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(20.0),
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(
                                'Skip',
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddStock(0), null));
                              },
                            )),
                        Container(
                            margin: EdgeInsets.all(10.0),
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(20.0),
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(
                                'Done',
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideRightRoute(AddStock(0), null));
                              },
                            )),
                      ],
                    ),
                    Container(
                      height: 15.0,
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 30.0),
                  child: RawMaterialButton(
                    fillColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(side: BorderSide()),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      addParty();
                    },
                  ),
                )
        ],
      )),
    );
  }

  addParty() async {
    if (_nameController.text != '' &&
        _addressController.text != '' &&
        _gstinController.text != '') {
      try {
        await Future.value(addPartyBE(
                isAddingSupplier == true ? 1 : 2,
                userId,
                _nameController.text,
                _addressController.text,
                _gstinController.text,
                _mobileController.text,
                _emailIdController.text,
                _remarksController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((partyid) {
          if (partyid != -1) {
            setState(() {
              isAddingSupplier = false;
              isAddingCustomer = false;
            });
            Fluttertoast.showToast(msg: "Party Created");
            if (widget.partyType == 1) {
              suppliers.add(Party(
                  partyid,
                  _nameController.text,
                  _addressController.text,
                  _emailIdController.text,
                  _gstinController.text,
                  _remarksController.text,
                  _mobileController.text));
              Navigator.pop(context);
            } else if (widget.partyType == 2) {
              customers.add(Party(
                  partyid,
                  _nameController.text,
                  _addressController.text,
                  _emailIdController.text,
                  _gstinController.text,
                  _remarksController.text,
                  _mobileController.text));
              Navigator.pop(context);
            }
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      } catch (exception) {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      Fluttertoast.showToast(msg: "Fill Mandatory Fields!");
    }
  }
}
