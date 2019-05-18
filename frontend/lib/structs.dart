class Company {
  Company(this.companyId, this.name, this.addr, this.gstin, this.mobNum,
      this.emailId);
  int companyId;
  String name;
  String addr;
  String gstin;
  int mobNum;
  String emailId;
}

class Ledger {
  String name;
  String group;
}

class Item {
  Item(this.itemId, this.name, this.mainGroup, this.subGroup, this.qtyAvailable,
      this.unit, this.price, this.taxPercent);
  int itemId;
  String name;
  String mainGroup;
  String subGroup;
  int qtyAvailable;
  String unit;
  String price;
  String taxPercent;
}

class TxnItem {
  TxnItem(this.itemId, this.qty, this.basePrice, this.taxPc);
  int itemId;
  int qty;
  String basePrice;
  String taxPc;
}

class Party {
  Party(this.partyId, this.name, this.addr, this.emailId, this.gstin,
      this.remarks, this.mobileNum);
  int partyId;
  String name;
  String addr;
  String emailId;
  String gstin;
  String remarks;
  String mobileNum;
}

class Txn {
  int txnId;
  DateTime txnDateTime;
  DateTime paymentDateTime;
  DateTime deliveryDateTime;
  Party party;
  String invNum;
  String paymentMethod;
  String paymentId;
  double totalPrice;
  String remarks;
  int qty;
}

class Emp {
  Emp(this.empdId, this.name, this.mobNum, this.designation, this.add, this.emailId,
      this.age);
  int empdId;
  String name;
  String mobNum;
  String designation;
  String add;
  String emailId;
  int age;
}

int userId = 1;
int presentCompanyId;
List<String> units = ["Kgs", "Metres", "Litres", "Boxes", "Numbers"];
List<Party> suppliers = [];
List<Emp> employees = [];
List<Party> customers = [];
List<Item> assets = [];
List<Item> stock_list = [];
List<String> payMethods = ["Cash", "Bank Account", "Credit", "Others"];
List<Company> companies = [];
List<TxnItem> txnItems = [];
List<MainGroup> mainGroups = [];
List<SubGroup> subGroups = [];
List<Item> allItems = [];

class MainGroup {
  MainGroup(this.mgId, this.name);
  int mgId;
  String name;
}

class SubGroup {
  SubGroup(this.subId, this.mainId, this.name);
  int subId;
  int mainId;
  String name;
}

List<String> salesParties = ["Sale of Asset", "Sale of Stock"];

List<String> purchaseParties = ["Purchase of Asset", "Purchase of Stock"];

List<String> paymentParties = [
  "Deposits",
  "Duties & Taxes",
  "Insurance",
  "Investments",
  "Misc. Expenses",
  "Office Maintanance Expences",
  "Purchase Payment",
  "Repaying Loans"
];

List<String> receiptParties = [
  "Availing Loan",
  "Received Capital",
  "Incentives",
  "Interest",
  "Return on Investment/Deposit",
  "Sales Receipt"
];

List<Goal> pendingGoals = [];
List<Goal> finishedGoals = [];

class Goal {
  int goalId;
  DateTime endDate;
  String goalTitle;
  String goalPlan;
  int noOfLevels;
}
