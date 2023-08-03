class PromoData {
  int id;
  String type;
  String title;
  String code;
  DateTime dateStart;
  DateTime dateExp;
  String description;
  double value;
  String status;
  String image;
  double minValueOrder;
  double maxValueDiscount;
  int quantity;

  PromoData({
    required this.id,
    required this.type,
    required this.title,
    required this.code,
    required this.dateStart,
    required this.dateExp,
    required this.description,
    required this.value,
    required this.status,
    required this.image,
    required this.minValueOrder,
    required this.maxValueDiscount,
    required this.quantity,
  });

  factory PromoData.fromJson(Map<String, dynamic> json) => PromoData(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    code: json["code"],
    dateStart: DateTime.parse(json["dateStart"]),
    dateExp: DateTime.parse(json["dateExp"]),
    description: json["description"],
    value: json["value"]?.toDouble(),
    status: json["status"],
    image: json["image"],
    minValueOrder: json["minValueOrder"],
    maxValueDiscount: json["maxValueDiscount"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "code": code,
    "dateStart": "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
    "dateExp": "${dateExp.year.toString().padLeft(4, '0')}-${dateExp.month.toString().padLeft(2, '0')}-${dateExp.day.toString().padLeft(2, '0')}",
    "description": description,
    "value": value,
    "status": status,
  };
}