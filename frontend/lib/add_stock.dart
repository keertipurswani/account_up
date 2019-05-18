import 'package:flutter/material.dart';
import 'navigation.dart';
import 'home.dart';
import 'backend_integration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'structs.dart';
import 'make_main_group.dart';
import 'make_sub_group.dart';

class AddStock extends StatefulWidget {
  AddStock(this.inventType);
  final int inventType;
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  bool isAddingStock;
  bool isAddingAsset;
  String _selectedMainGroup;
  String _selectedSubGroup;
  String _selectedUom;
  TextEditingController _mainGroupController;
  TextEditingController _subGroupController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController _nameController;
  TextEditingController _remarksController;
  TextEditingController _basePriceController;
  TextEditingController _qtyController;
  TextEditingController _taxPcController;
  TextEditingController _uomController;

  @override
  void initState() {
    super.initState();
    isAddingStock = false;
    isAddingAsset = false;
    if (widget.inventType == 1) {
      isAddingAsset = true;
    } else if (widget.inventType == 2) {
      isAddingStock = true;
    }
    _mainGroupController = TextEditingController(text: '');
    _subGroupController = TextEditingController(text: '');
    _nameController = TextEditingController(text: '');
    _remarksController = TextEditingController(text: '');
    _basePriceController = TextEditingController(text: '');
    _qtyController = TextEditingController(text: '');
    _taxPcController = TextEditingController(text: '');
    _uomController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _mainGroupController.dispose();
    _subGroupController.dispose();
    _nameController.dispose();
    _remarksController.dispose();
    _basePriceController.dispose();
    _qtyController.dispose();
    _taxPcController.dispose();
    _uomController.dispose();
    super.dispose();
  }

  void _onMainGroupChanged(String newGroup) {
    if (newGroup != null) {
      setState(() {
        _selectedMainGroup = newGroup;
      });
    }
  }

  void _onSubGroupChanged(String newGroup) {
    if (newGroup != null) {
      setState(() {
        _selectedSubGroup = newGroup;
      });
    }
  }

  void _onUomChanged(String newUom) {
    if (newUom != null) {
      setState(() {
        _selectedUom = newUom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Add Inventory'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  decoration: widget.inventType == 0
                      ? BoxDecoration(border: Border.all())
                      : BoxDecoration(),
                  margin: EdgeInsets.all(20.0),
                  height: 300.0,
                  child: (isAddingStock == false && isAddingAsset == false)
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
                                        isAddingAsset = true;
                                      });
                                    },
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Text('Add Asset')),
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
                                        isAddingStock = true;
                                      });
                                    },
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Text('Add Stock')),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ],
                          ))
                      : Container(
                          margin: EdgeInsets.all(
                              widget.inventType == 0 ? 10.0 : 0.0),
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
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: 100,
                                              child: Text('Main Group*')),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(5.0),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: _selectedMainGroup,
                                                items: mainGroups
                                                    .map((MainGroup value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.name,
                                                    child: Text(value.name),
                                                  );
                                                }).toList(),
                                                onChanged: (String value) {
                                                  _onMainGroupChanged(value);
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
                                                      MakeMainGroup(), null));
                                            },
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: 100,
                                              child: Text('Sub Group*')),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(5.0),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: _selectedSubGroup,
                                                items: subGroups
                                                    .map((SubGroup value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.name,
                                                    child: Text(value.name),
                                                  );
                                                }).toList(),
                                                onChanged: (String value) {
                                                  _onSubGroupChanged(value);
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
                                                      SubMainGroup(), null));
                                            },
                                          )
                                        ],
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Base Price'),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        onSaved: (String val) {
                                          _basePriceController.text = val;
                                        },
                                        controller: _basePriceController,
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Quantity'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (String val) {
                                          _qtyController.text = val;
                                        },
                                        controller: _qtyController,
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Tax Percent'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (String val) {
                                          _taxPcController.text = val;
                                        },
                                        controller: _taxPcController,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              width: 100,
                                              child: Text('Units of measure*')),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(5.0),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: _selectedUom,
                                                items:
                                                    units.map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String value) {
                                                  _onUomChanged(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              widget.inventType == 0
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
                                              fillColor: Theme.of(context)
                                                  .primaryColor,
                                              padding: EdgeInsets.all(10.0),
                                              shape: CircleBorder(
                                                  side: BorderSide()),
                                              child: Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isAddingAsset = false;
                                                  isAddingStock = false;
                                                });
                                              },
                                            ),
                                            RawMaterialButton(
                                              fillColor: Theme.of(context)
                                                  .primaryColor,
                                              padding: EdgeInsets.all(10.0),
                                              shape: CircleBorder(
                                                  side: BorderSide()),
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                addStock();
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
            widget.inventType == 0
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
                                  Navigator.push(
                                      context, SlideRightRoute(Home(), null));
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
                                  Navigator.push(
                                      context, SlideRightRoute(Home(), null));
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
                        addStock();
                      },
                    ),
                  )
          ],
        )));
  }

  addStock() async {
    if (_nameController.text != '' &&
        _selectedMainGroup != null &&
        _selectedSubGroup != null) {
      try {
        int mainGroupId =
            (mainGroups.firstWhere((found) => found.name == _selectedMainGroup))
                .mgId;
        int subGroupId =
            (subGroups.firstWhere((found) => found.name == _selectedSubGroup))
                .subId;
        await Future.value(addStockBE(
                presentCompanyId,
                isAddingAsset == true ? 1 : 2,
                mainGroupId,
                subGroupId,
                _nameController.text,
                _remarksController.text,
                _basePriceController.text,
                _qtyController.text != '' ? int.parse(_qtyController.text) : 0,
                _taxPcController.text,
                _uomController.text))
            .timeout(Duration(seconds: 90), onTimeout: () {
          Fluttertoast.showToast(msg: "Time out occurred");
        }).then((itemid) {
          if (itemid != -1) {
            setState(() {
              isAddingAsset = false;
              isAddingStock = false;
            });
            if (isAddingAsset == true) {
              assets.add(Item(
                  itemid,
                  _nameController.text,
                  _mainGroupController.text,
                  _subGroupController.text,
                  _qtyController.text != ''
                      ? int.parse(_qtyController.text)
                      : 0,
                  _selectedUom,
                  _basePriceController.text,
                  _taxPcController.text));
              Navigator.pop(context);
            } else {
              stock_list.add(Item(
                  itemid,
                  _nameController.text,
                  _mainGroupController.text,
                  _subGroupController.text,
                  _qtyController.text != ''
                      ? int.parse(_qtyController.text)
                      : 0,
                  _selectedUom,
                  _basePriceController.text,
                  _taxPcController.text));
              Navigator.pop(context);
            }
            Fluttertoast.showToast(msg: "Item Created");
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      } catch (exception) {
        print(exception.toString());
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      Fluttertoast.showToast(msg: "Fill Mandatory Fields!");
    }
  }
}
