import 'package:hommie/core/models/promo/promo_data.dart';

class Promo {
  List<PromoData> data;
  int result;

  Promo({
    required this.data,
    required this.result,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
    data: List<PromoData>.from(json["data"].map((x) => PromoData.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "result": result,
  };
}