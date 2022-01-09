import 'package:kupol_app/components/role.dart';

class User {
  final int id;
  final String lastname;
  final String firstname;
  final String patronymic;
  final String phone;
  final String address;
  final Role role;
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
