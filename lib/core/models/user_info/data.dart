class Data {
  int id;
  String name;
  String email;
  String phoneNumber;
  dynamic gender;
  dynamic dob;
  dynamic address;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.gender,
    this.dob,
    this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    gender: json["gender"],
    dob: json["dob"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "gender": gender,
    "dob": dob,
    "address": address,
  };
}