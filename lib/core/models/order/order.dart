
import 'order_data.dart';

class Order {
  List<OrderData> data;
  int result;

  Order({
    required this.data,
    required this.result,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    data: List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}