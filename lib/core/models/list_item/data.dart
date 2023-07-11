import 'package:hommie/core/models/list_item/detail_item.dart';
import 'package:hommie/core/models/list_item/image_list.dart';

class Data {
  int id;
  String name;
  String material;
  DateTime? createDate;
  List<ImageList> imageList;
  List<Detail> details;
  int subId;
  String subName;
  int cateId;
  String cateName;

  Data({
    required this.id,
    required this.name,
    required this.material,
    required this.createDate,
    required this.imageList,
    required this.details,
    required this.subId,
    required this.subName,
    required this.cateId,
    required this.cateName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    material: json["material"],
    createDate: (json["createDate"] != null) ? DateTime.parse(json["createDate"]) : null,
    imageList: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    subId: json["subId"],
    subName: json["subName"],
    cateId: json["cateId"],
    cateName: json["cateName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "material": material,
    "createDate": "${createDate!.year.toString().padLeft(4, '0')}-${createDate!.month.toString().padLeft(2, '0')}-${createDate!.day.toString().padLeft(2, '0')}",
    "imageList": List<dynamic>.from(imageList.map((x) => x.toJson())),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "subId": subId,
    "subName": subName,
    "cateId": cateId,
    "cateName": cateName,
  };
}