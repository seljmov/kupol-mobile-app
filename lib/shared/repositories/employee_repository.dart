import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kupol_app/shared/models/employee_model.dart';

class EmployeeRepository {
  static const _employeeInfoKey = "employee_info";

  /// Сохранить данные о пользователе
  Future<void> saveEmployeeInfo(Map<String, dynamic> info) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: _employeeInfoKey);
    await storage.write(key: _employeeInfoKey, value: json.encode(info));
  }

  /// Получить данные о пользователе
  Future<Employee> getEmployeeInfo() async {
    final storage = new FlutterSecureStorage();
    var str = await storage.read(key: _employeeInfoKey);
    var employee = Employee.fromJson(json.decode(str!));
    return employee;
  }

  /// Удалить информацию о пользователе
  Future<void> removeEmployeeInfo() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: _employeeInfoKey);
  }

  /// Удалить всю нформацию из хранилища
  Future<void> removeInfoFromStorage() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }
}
