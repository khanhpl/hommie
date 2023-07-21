import 'list_item.dart';

class OrderData {
  int orderId;
  String orderCode;
  List<ListItem> listItems;
  double totalPrice;
  String orderStatus;

  OrderData({
    required this.orderId,
    required this.orderCode,
    required this.listItems,
    required this.totalPrice,
    required this.orderStatus,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderId: json["orderId"],
    orderCode: json["orderCode"],
    listItems: List<ListItem>.from(json["listItems"].map((x) => ListItem.fromJson(x))),
    totalPrice: json["totalPrice"],
    orderStatus: json["orderStatus"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderCode": orderCode,
    "listItems": List<dynamic>.from(listItems.map((x) => x.toJson())),
    "totalPrice": totalPrice,
    "orderStatus": orderStatus,
  };
}