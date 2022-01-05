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
}
