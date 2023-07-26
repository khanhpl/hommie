class Headers {
  List<String> server;
  List<String> date;
  List<String> contentType;
  List<String> transferEncoding;
  List<String> connection;
  List<String> vary;
  List<String> xContentTypeOptions;
  List<String> xXssProtection;
  List<String> pragma;
  List<String> strictTransportSecurity;
  List<String> allow;

  Headers({
    required this.server,
    required this.date,
    required this.contentType,
    required this.transferEncoding,
    required this.connection,
    required this.vary,
    required this.xContentTypeOptions,
    required this.xXssProtection,
    required this.pragma,
    required this.strictTransportSecurity,
    required this.allow,
  });

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    server: List<String>.from(json["Server"].map((x) => x)),
    date: List<String>.from(json["Date"].map((x) => x)),
    contentType: List<String>.from(json["Content-Type"].map((x) => x)),
    transferEncoding: List<String>.from(json["Transfer-Encoding"].map((x) => x)),
    connection: List<String>.from(json["Connection"].map((x) => x)),
    vary: List<String>.from(json["Vary"].map((x) => x)),
    xContentTypeOptions: List<String>.from(json["x-content-type-options"].map((x) => x)),
    xXssProtection: List<String>.from(json["x-xss-protection"].map((x) => x)),
    pragma: List<String>.from(json["pragma"].map((x) => x)),
    strictTransportSecurity: List<String>.from(json["strict-transport-security"].map((x) => x)),
    allow: List<String>.from(json["Allow"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Server": List<dynamic>.from(server.map((x) => x)),
    "Date": List<dynamic>.from(date.map((x) => x)),
    "Content-Type": List<dynamic>.from(contentType.map((x) => x)),
    "Transfer-Encoding": List<dynamic>.from(transferEncoding.map((x) => x)),
    "Connection": List<dynamic>.from(connection.map((x) => x)),
    "Vary": List<dynamic>.from(vary.map((x) => x)),
    "x-content-type-options": List<dynamic>.from(xContentTypeOptions.map((x) => x)),
    "x-xss-protection": List<dynamic>.from(xXssProtection.map((x) => x)),
    "pragma": List<dynamic>.from(pragma.map((x) => x)),
    "strict-transport-security": List<dynamic>.from(strictTransportSecurity.map((x) => x)),
    "Allow": List<dynamic>.from(allow.map((x) => x)),
  };
}