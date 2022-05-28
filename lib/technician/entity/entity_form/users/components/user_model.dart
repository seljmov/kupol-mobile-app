import 'dart:convert';

class User {
  final int id;
  final String lastname;
  final String firstname;
  final String patronymic;
  final String phone;
  final String address;
  final String role;
  final String pin;

  User({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.patronymic,
    required this.phone,
    required this.address,
    required this.role,
    required this.pin,
  });

  String getName() {
    return "$lastname ${firstname[0]}.${patronymic[0]}.";
  }

  String getFullname() {
    return "$lastname $firstname $patronymic";
  }

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        lastname: json["lastname"],
        firstname: json["firstname"],
        patronymic: json["patronymic"],
        phone: json["phone_number"],
        address: json["address"],
        role: json["role"],
        pin: json["pin"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "lastname": lastname,
        "firstname": firstname,
        "patronymic": patronymic,
        "phone_number": phone,
        "address": address,
        "role": role,
        "pin": pin,
      };
}
