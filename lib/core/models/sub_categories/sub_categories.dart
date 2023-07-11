import '../sub_categories/datum.dart';

class SubCategories {
  List<Datum> data;
  int result;

  SubCategories({
    required this.data,
    required this.result,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}