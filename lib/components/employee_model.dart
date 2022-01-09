import 'package:kupol_app/components/role.dart';

class Employee {
  final int id;
  final String lastname;
  final String firstname;
  final String patronymic;
  final String phone;
  final String address;
  final Role role;
  final String pin;
  final String login;
  final String password;

  Employee({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.patronymic,
    required this.phone,
    required this.address,
    required this.role,
    required this.pin,
    required this.login,
    required this.password,
  });

  String getName() {
    return "$lastname ${firstname[0]}.${patronymic[0]}.";
  }

  String getFullname() {
    return "$lastname $firstname $patronymic";
  }

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        lastname: json["lastname"],
        firstname: json["firstname"],
        patronymic: json["patronymic"],
        phone: json["phone_number"],
        address: json["address"],
        role: Role.values.firstWhere((e) => e.toString() == json["role"]),
        pin: json["pin"],
        login: json["login"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lastname": lastname,
        "firstname": firstname,
        "patronymic": patronymic,
        "phone_number": phone,
        "address": address,
        "role": role.toString(),
        "pin": pin,
        "login": login,
        "password": password,
      };
}
