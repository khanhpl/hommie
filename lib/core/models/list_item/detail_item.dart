import 'item_image.dart';

class Detail {
  int id;
  String size;
  String color;
  int quantity;
  List<ItemImage> itemImages;
  double price;
  String description;

  Detail({
    required this.id,
    required this.size,
    required this.color,
    required this.quantity,
    required this.itemImages,
    required this.price,
    required this.description,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    size: json["size"],
    color: json["color"],
    quantity: json["quantity"],
    itemImages: List<ItemImage>.from(json["itemImages"].map((x) => ItemImage.fromJson(x))),
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size": size,
    "color": color,
    "quantity": quantity,
    "itemImages": List<dynamic>.from(itemImages.map((x) => x.toJson())),
    "price": price,
    "description": description,
  };
}