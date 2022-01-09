import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kupol_app/components/employee_model.dart';

class EmployeeRepository {
  /// Сохранить данные о пользователе
  Future<void> saveEmployeeInfo(Map<String, dynamic> info) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "employee_info", value: json.encode(info));
  }

  /// Получить данные о пользователе
  Future<Employee?> getEmployeeInfo() async {
    var isLoggedIn = await userHasBeenLoggedIn();
    if (!isLoggedIn) return null;

    final storage = new FlutterSecureStorage();
    var str = await storage.read(key: "employee_info");
    var employee = Employee.fromJson(json.decode(str!));
    return employee;
  }

  /// Удалить информацию
  Future<void> removeInfo() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  /// Проверить авторизованность пользователя
  Future<bool> userHasBeenLoggedIn() async {
    final storage = new FlutterSecureStorage();
    return await storage.containsKey(key: "employee_info");
  }
}
