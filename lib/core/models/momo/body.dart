class Body {
  String partnerCode;
  String orderId;
  String requestId;
  int amount;
  String responseTime;
  String message;
  int resultCode;
  String payUrl;
  dynamic deeplink;
  dynamic qrCodeUrl;
  dynamic deeplinkMiniApp;

  Body({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
    this.deeplink,
    this.qrCodeUrl,
    this.deeplinkMiniApp,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    partnerCode: json["partnerCode"],
    orderId: json["orderId"],
    requestId: json["requestId"],
    amount: json["amount"],
    responseTime: json["responseTime"],
    message: json["message"],
    resultCode: json["resultCode"],
    payUrl: json["payUrl"],
    deeplink: json["deeplink"],
    qrCodeUrl: json["qrCodeUrl"],
    deeplinkMiniApp: json["deeplinkMiniApp"],
  );

  Map<String, dynamic> toJson() => {
    "partnerCode": partnerCode,
    "orderId": orderId,
    "requestId": requestId,
    "amount": amount,
    "responseTime": responseTime,
    "message": message,
    "resultCode": resultCode,
    "payUrl": payUrl,
    "deeplink": deeplink,
    "qrCodeUrl": qrCodeUrl,
    "deeplinkMiniApp": deeplinkMiniApp,
  };
}