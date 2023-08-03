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
  String userReceive;
  String reason;
  String paymentType;
  OrderData({
    required this.orderId,
    required this.orderCode,
    required this.listItems,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderDate,
    required this.phoneNumber,
    required this.address,
    required this.userReceive,
    required this.reason,
    required this.paymentType,
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
    userReceive: json["userReceive"],
    reason: (json["reason"] != null) ? json["reason"] : "",
    paymentType: json["paymentType"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderCode": orderCode,
    "listItems": List<dynamic>.from(listItems.map((x) => x.toJson())),
    "totalPrice": totalPrice,
    "orderStatus": orderStatus,
  };
}