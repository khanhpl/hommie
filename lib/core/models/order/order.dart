
import 'Datum.dart';

class Order {
  List<Datum> data;
  int result;

  Order({
    required this.data,
    required this.result,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}