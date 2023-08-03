import 'cart_item_data.dart';

class CartItems {
  List<CartItemData> data;
  int result;

  CartItems({
    required this.data,
    required this.result,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
    data: List<CartItemData>.from(json["data"].map((x) => CartItemData.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}
