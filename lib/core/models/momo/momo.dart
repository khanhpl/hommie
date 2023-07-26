import 'momo_data.dart';

class Momo {
  MomoData data;
  dynamic result;

  Momo({
    required this.data,
    this.result,
  });

  factory Momo.fromJson(Map<String, dynamic> json) => Momo(
    data: MomoData.fromJson(json["data"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result,
  };
}