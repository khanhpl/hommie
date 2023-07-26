import 'package:hommie/core/models/list_item/list_item_data.dart';

class ListItem {
  List<ListItemData> data;
  int result;

  ListItem({
    required this.data,
    required this.result,
  });

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    data: List<ListItemData>.from(json["data"].map((x) => ListItemData.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}