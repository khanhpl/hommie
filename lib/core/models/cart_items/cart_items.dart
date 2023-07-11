import 'datum.dart';

class CartItems {
  List<Datum> data;
  int result;

  CartItems({
    required this.data,
    required this.result,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}
