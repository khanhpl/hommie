import 'data.dart';

class ListItem {
  List<Data> data;
  int result;

  ListItem({
    required this.data,
    required this.result,
  });

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}