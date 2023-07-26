import 'body.dart';
import 'header.dart';

class MomoData {
  Headers headers;
  Body body;
  String statusCode;
  int statusCodeValue;

  MomoData({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory MomoData.fromJson(Map<String, dynamic> json) => MomoData(
    headers: Headers.fromJson(json["headers"]),
    body: Body.fromJson(json["body"]),
    statusCode: json["statusCode"],
    statusCodeValue: json["statusCodeValue"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "body": body.toJson(),
    "statusCode": statusCode,
    "statusCodeValue": statusCodeValue,
  };
}