class CartItemData {
  int cartItemId;
  int itemDetailId;
  String itemName;
  String itemImage;
  String material;
  String size;
  String color;
  int quantity;
  double price;

  CartItemData({
    required this.cartItemId,
    required this.itemDetailId,
    required this.itemName,
    required this.itemImage,
    required this.material,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) => CartItemData(
        cartItemId: json["cartItemId"],
        itemDetailId: json["itemDetailId"],
        itemName: json["itemName"],
        itemImage: json["itemImage"],
        material: json["material"],
        size: json["size"],
        color: json["color"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "itemDetailId": itemDetailId,
        "itemName": itemName,
        "itemImage": itemImage,
        "material": material,
        "size": size,
        "color": color,
        "quantity": quantity,
        "price": price,
      };
}
