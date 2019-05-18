import 'package:flutter/material.dart';
import 'navigation.dart';
import 'add_stock.dart';
import 'structs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTxnItem extends StatefulWidget {
  @override
  _AddTxnItemState createState() => _AddTxnItemState();
}

class _AddTxnItemState extends State<AddTxnItem> {
  String _selectedItem;
  TextEditingController _qtyController;
  TextEditingController _priceController;
  TextEditingController _taxController;

  void _onItemChanged(String newItem) {
    setState(() {
      _selectedItem = newItem;
    });
  }

  @override
  void initState() {
    super.initState();
    allItems.removeRange(0, allItems.length);
    allItems = [assets, stock_list].expand((x) => x).toList();
    _qtyController = TextEditingController(text: '');
    _priceController = TextEditingController(text: '');
    _taxController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: 100, child: Text('Item Name')),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedItem,
                      items: allItems.map((Item value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        _onItemChanged(value);
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context, SlideRightRoute(AddStock(0), null));
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 100, child: Text('Quantity')),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _qtyController,
                      onSaved: (String val) {
                        _qtyController.text = val;
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 100, child: Text('Price')),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _priceController,
                      onSaved: (String val) {
                        _priceController.text = val;
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 100, child: Text('Tax')),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _taxController,
                      onSaved: (String val) {
                        _taxController.text = val;
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 0.0),
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  onPressed: () {
                    Item item = allItems.firstWhere(
                        (itemFound) => itemFound.name == _selectedItem,
                        orElse: () => null);
                    if (item != null) {
                      txnItems.add(TxnItem(
                          item.itemId,
                          _qtyController.text != ''
                              ? int.parse(_qtyController.text)
                              : 0,
                          _priceController.text,
                          _taxController.text));
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: 'Something went wrong.');
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
