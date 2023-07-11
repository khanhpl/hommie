class Detail {
  int id;
  String color;
  String size;
  double price;
  int quantity;
  String description;
  dynamic rate;
  String status;

  Detail({
    required this.id,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.description,
    this.rate,
    required this.status,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    color: json["color"],
    size: json["size"],
    price: json["price"],
    quantity: json["quantity"],
    description: json["description"],
    rate: json["rate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "size": size,
    "price": price,
    "quantity": quantity,
    "description": description,
    "rate": rate,
    "status": status,
  };
}