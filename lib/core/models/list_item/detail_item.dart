class Detail {
  int id;
  String color;
  String size;
  double price;
  int quantity;
  String description;
  String status;

  Detail({
    required this.id,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.description,
    required this.status,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    color: json["color"],
    size: json["size"],
    price: (json["price"] != null) ? json["price"] : 0,
    quantity: (json["quantity"] != null) ? json["quantity"] : 0,
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "size": size,
    "price": price,
    "quantity": quantity,
    "description": description,
    "status": status,
  };
}