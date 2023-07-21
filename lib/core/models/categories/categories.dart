import 'category.dart';

class Categories {
  List<Category> data;
  int result;

  Categories({
    required this.data,
    required this.result,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}