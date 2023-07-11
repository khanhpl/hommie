import 'package:hommie/core/models/user_info/data.dart';

class UserInfo {
  Data data;
  dynamic result;

  UserInfo({
    required this.data,
    this.result,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    data: Data.fromJson(json["data"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result,
  };
}
