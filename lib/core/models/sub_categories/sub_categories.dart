import '../sub_categories/sub_category.dart';

class SubCategories {
  List<SubCategory> data;
  int result;

  SubCategories({
    required this.data,
    required this.result,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
    data: List<SubCategory>.from(json["data"].map((x) => SubCategory.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}