class SubCategory {
  int id;
  String name;
  String status;
  int cateId;

  SubCategory({
    required this.id,
    required this.name,
    required this.status,
    required this.cateId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    cateId: json["cateId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "cateId": cateId,
  };
}
