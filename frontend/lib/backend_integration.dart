import 'package:http/http.dart' as http;
import 'dart:convert';
import 'structs.dart';
import 'package:fluttertoast/fluttertoast.dart';

String ip = "django-env.56shvspnnb.ap-south-1.elasticbeanstalk.com";

getItemObjectsArray() {
  var obj = [];
  Item item;
  for (int i = 0; i < txnItems.length; i++) {
    item = allItems
        .firstWhere((itemFound) => itemFound.itemId == txnItems[i].itemId);
    obj.add({
      "item_id": item.itemId,
      "item_base_price": item.price,
      "item_quantity": item.qtyAvailable,
      "item_tax_percent": item.taxPercent,
      "item_total_price":
          ((double.parse(item.price) * item.qtyAvailable).truncateToDouble())
              .toString()
    });
  }
  return obj;
}

addTxnBE(
    String txnDateTime,
    String payDateTime,
    int partyId,
    String invNum,
    int payMeth,
    String total,
    int qty,
    String remarks,
    int txnType,
    String txnGroupType) async {
  String url = "http://" + ip + "/add_transaction";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "companyId": presentCompanyId,
        "transaction_date": txnDateTime,
        "transaction_ref_id": 0,
        "transaction_type": txnType,
        "transaction_group_type": 1,
        "transaction_party_id": partyId,
        "transaction_invoice_number": invNum,
        "transaction_total_price": total,
        "transaction_remarks": remarks,
        "pay_now": 1,
        "item_details": getItemObjectsArray(),
        "payment_details": [
          {
            "payment_method": 1,
            "payment_amount": 435,
            "payment_date": "2019-04-27",
            "payment_id": 5232,
            "payment_remarks": "blah"
          },
        ]
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    txnItems.removeRange(0, txnItems.length);
    return 1;
  }
  return 0;
}

Future<bool> createUserBE(String userName, String pw) async {
  String url = "http://" + ip + "/create_user";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": userName, "password": pw}));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    userId = res["User_id"];
    return true;
  } else {
    return false;
  }
}

Future<bool> loginBE(String userName, String pw) async {
  String url = "http://" + ip + "/login";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": userName, "password": pw}));
  Fluttertoast.showToast(msg: response.statusCode.toString());
  Fluttertoast.showToast(msg: response.headers.toString());
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    userId = res["User_id"];
    return true;
  } else {
    return false;
  }
}

Future<int> createCompanyBE(int userId, String name, String addr, String gstin,
    String mobNum, String emailId) async {
  String url = "http://" + ip + "/create_company";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "name": name,
        "addr": addr,
        "gstin": gstin,
        "mobNum": mobNum,
        "emailId": emailId
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    return res["Company_id"];
  } else {
    return -1;
  }
}

Future<int> addPartyBE(int partyType, int userId, String name, String addr,
    String gstin, String mobNum, String emailId, String remarks) async {
  String url = "http://" + ip + "/add_party";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "companyId": presentCompanyId,
        "party_type": partyType,
        "userId": userId,
        "name": name,
        "addr": addr,
        "gstin": gstin,
        "mobNum": mobNum,
        "emailId": emailId,
        "remarks": remarks
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    return res["party_id"];
  } else {
    return -1;
  }
}

Future<int> addEmpBE(String name, String addr, String mobNum, String emailId,
    String age, String desig) async {
  String url = "http://" + ip + "/add_emp";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'cmp_id': presentCompanyId,
        'name': name,
        'addr': addr,
        'desig': desig,
        'mob_num': mobNum,
        'email': emailId,
        'age': age
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    //return res["party_id"];
  } else {
    return -1;
  }
}

Future<int> getEmpsBE() async {
  String url = "http://" + ip + '/get_emp';
  var response =
      await http.get(url, headers: {'cmpid': presentCompanyId.toString()});
  if (response?.statusCode == 200 &&
      response?.body != null &&
      response?.body != '') {
    if ((jsonDecode(response.body))["Status"] == 1) {
      employees.clear();
      var resp = (jsonDecode(response.body))["Data"];
      for (int i = 0; i < resp.length; i++) {
        var data = resp[i];
        Emp emp = Emp(data["empid"], data["ename"], data["phone"],
            data["desig"], data["addr"], data["email"], data["age"]);
        employees.add(emp);
      }
      return 1;
    }
  }
  return 0;
}

Future<int> addStockBE(
    int companyId,
    int itemType,
    int mainGroupId,
    int subGroupId,
    String itemName,
    String remarks,
    String basePrice,
    int qty,
    String taxPercent,
    String uom) async {
  String url = "http://" + ip + "/add_stock_item";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "companyId": companyId,
        "item_type": itemType,
        "main_group_id": mainGroupId,
        "sub_group_id": subGroupId,
        "item_name": itemName,
        "remarks": remarks,
        "base_price": basePrice,
        "quantity": qty,
        "tax_percent": taxPercent,
        "unit_of_measure": uom
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    return res["item_id"];
  } else {
    return -1;
  }
}

Future<int> addMainGroupBE(String mainGroupName) async {
  String url = "http://" + ip + "/add_stock_main_group";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"companyId": presentCompanyId, "main_group_name": mainGroupName}));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    return res["main_group_id"];
  } else {
    return -1;
  }
}

Future<int> subGroupBE(int mainGroupId, String subGroupName) async {
  String url = "http://" + ip + "/add_stock_sub_group";
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "companyId": presentCompanyId,
        "main_group_id": mainGroupId,
        "sub_group_name": subGroupName
      }));
  var res = jsonDecode(response?.body);
  if (res != null && res != '' && res["Status"] == 1) {
    return res["sub_group_id"];
  } else {
    return -1;
  }
}

Future<int> getPartiesBE(int partyType) async {
  String url = "http://" + ip + '/get_party_details';
  var response = await http.get(url, headers: {
    "companyId": presentCompanyId.toString(),
    "partytype": partyType.toString()
  });
  if (response?.statusCode == 200 &&
      response?.body != null &&
      response?.body != '') {
    if ((jsonDecode(response.body))["Status"] == 1) {
      if (partyType == 1) {
        suppliers.removeRange(0, suppliers.length);
      } else {
        customers.removeRange(0, customers.length);
      }
      var resp = (jsonDecode(response.body))["Data"];
      for (int i = 0; i < resp.length; i++) {
        var data = resp[i];
        Party party = Party(
            data["PARTY_ID"],
            data["PARTY_NAME"],
            data["PARTY_ADDR"],
            data["PARTY_EMAIL"],
            data["PARTY_GSTIN"],
            data["PARTY_REMARKS"],
            data["PARTY_PHONE"]);

        if (partyType == 1) {
          suppliers.add(party);
        } else {
          customers.add(party);
        }
      }
      return 0;
    }
  }
  return 0;
}

Future<int> getTxnsBE(int partyType) async {
  String url = "http://" + ip + '/get_transaction';
  var response =
      await http.get(url, headers: {"companyId": presentCompanyId.toString()});
  if (response?.statusCode == 200 &&
      response?.body != null &&
      response?.body != '') {
    if ((jsonDecode(response.body))["Status"] == 1) {
      if (partyType == 1) {
        suppliers.removeRange(0, suppliers.length);
      } else {
        customers.removeRange(0, customers.length);
      }
      var resp = (jsonDecode(response.body))["Data"];
      for (int i = 0; i < resp.length; i++) {
        var data = resp[i];
        Party party = Party(
            data["PARTY_ID"],
            data["PARTY_NAME"],
            data["PARTY_ADDR"],
            data["PARTY_EMAIL"],
            data["PARTY_GSTIN"],
            data["PARTY_REMARKS"],
            data["PARTY_PHONE"]);

        if (partyType == 1) {
          suppliers.add(party);
        } else {
          customers.add(party);
        }
      }
      return 0;
    }
  }
  return 0;
}

Future<int> getItemsBE(int itemType) async {
  String url = "http://" + ip + '/get_item_details';
  var response = await http.get(url, headers: {
    "companyId": presentCompanyId.toString(),
    "itemtype": itemType.toString()
  });
  if (response?.statusCode == 200 &&
      response?.body != null &&
      response?.body != '') {
    if ((jsonDecode(response.body))["Status"] == 1) {
      if (itemType == 1) {
        assets.removeRange(0, assets.length);
      } else {
        stock_list.removeRange(0, stock_list.length);
      }
      var resp = jsonDecode(response.body);
      var data = resp["DATA"];
      for (int j = 0; j < data.length; j++) {
        var mainGroup = ((data[j])["MAIN_GROUP_NAME"]);
        var groups = ((data[j])["ITEM_GROUP_LIST"]);
        for (int k = 0; k < groups.length; k++) {
          var subGroup = ((groups[k])["SUB_GROUP_NAME"]);
          var items = ((groups[k])["ITEM_DETAILS"]);
          for (int i = 0; i < items.length; i++) {
            var data = items[i];
            Item party = Item(
                data["ITEM_ID"],
                data["ITEM_NAME"],
                mainGroup,
                subGroup,
                data["ITEM_QUANTITY"],
                data["ITEM_UNIT_OF_MEASURE"],
                data["ITEM_PRICE"],
                data["ITEM_TAX_PERCENT"]);

            if (itemType == 1) {
              assets.add(party);
            } else {
              stock_list.add(party);
            }
          }
        }
      }
      return 0;
    }
  }
  return 0;
}
