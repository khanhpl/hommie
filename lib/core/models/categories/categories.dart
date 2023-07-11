import 'datum.dart';

class Categories {
  List<Datum> data;
  int result;

  Categories({
    required this.data,
    required this.result,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}