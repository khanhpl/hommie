import 'package:hommie/core/models/list_item/detail_item.dart';

class ListItemData {
  int id;
  String avatar;
  String name;
  String material;
  DateTime createDate;
  List<Detail> details;
  int subId;
  String subName;
  int cateId;
  String cateName;
  dynamic checkNumber;
  int buyNumber;

  ListItemData({
    required this.id,
    required this.avatar,
    required this.name,
    required this.material,
    required this.createDate,
    required this.details,
    required this.subId,
    required this.subName,
    required this.cateId,
    required this.cateName,
    this.checkNumber,
    required this.buyNumber,
  });

  factory ListItemData.fromJson(Map<String, dynamic> json) => ListItemData(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    material: json["material"],
    createDate: DateTime.parse(json["createDate"]),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    subId: json["subId"],
    subName: json["subName"],
    cateId: json["cateId"],
    cateName: json["cateName"],
    checkNumber: json["checkNumber"],
    buyNumber: json["buyNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "material": material,
    "createDate": "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "subId": subId,
    "subName": subName,
    "cateId": cateId,
    "cateName": cateName,
    "checkNumber": checkNumber,
  };
}