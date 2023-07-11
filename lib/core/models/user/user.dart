import 'authority.dart';

class User {
  List<Authority> authorities;
  int id;
  String name;
  String email;
  String phoneNumber;
  String password;
  int iat;
  int exp;

  User({
    required this.authorities,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.iat,
    required this.exp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    iat: json["iat"],
    exp: json["exp"],
  );

  Map<String, dynamic> toJson() => {
    "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
    "iat": iat,
    "exp": exp,
  };
}