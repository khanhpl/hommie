class Datum {
  int id;
  String name;
  String status;
  int cateId;

  Datum({
    required this.id,
    required this.name,
    required this.status,
    required this.cateId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
