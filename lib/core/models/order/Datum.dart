import 'list_item.dart';

class Datum {
  int orderId;
  String orderCode;
  List<ListItem> listItems;
  double totalPrice;
  String orderStatus;

  Datum({
    required this.orderId,
    required this.orderCode,
    required this.listItems,
    required this.totalPrice,
    required this.orderStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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