class ListItem {
  int itemId;
  String itemName;
  String itemImage;
  String material;
  String size;
  String color;
  int orderQuantity;
  double price;

  ListItem({
    required this.itemId,
    required this.itemName,
    required this.itemImage,
    required this.material,
    required this.size,
    required this.color,
    required this.orderQuantity,
    required this.price,
  });

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    itemId: json["itemId"],
    itemName: json["itemName"],
    itemImage: json["itemImage"],
    material: json["material"],
    size: json["size"],
    color: json["color"],
    orderQuantity: json["orderQuantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "itemName": itemName,
    "itemImage": itemImage,
    "material": material,
    "size": size,
    "color": color,
    "orderQuantity": orderQuantity,
    "price": price,
  };
}