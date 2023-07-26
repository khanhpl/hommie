import 'list_item.dart';

class OrderData {
  int orderId;
  String orderCode;
  List<ListItem> listItems;
  double totalPrice;
  String orderStatus;
  String orderDate;
  String phoneNumber;
  String address;
  OrderData({
    required this.orderId,
    required this.orderCode,
    required this.listItems,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderDate,
    required this.phoneNumber,
    required this.address
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderId: json["orderId"],
    orderCode: json["orderCode"],
    listItems: List<ListItem>.from(json["listItems"].map((x) => ListItem.fromJson(x))),
    totalPrice: json["totalPrice"],
    orderStatus: json["orderStatus"],
    orderDate: json["orderDate"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderCode": orderCode,
    "listItems": List<dynamic>.from(listItems.map((x) => x.toJson())),
    "totalPrice": totalPrice,
    "orderStatus": orderStatus,
  };
}