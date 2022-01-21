import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kupol_app/local/employee_service.dart';
import 'package:kupol_app/shared/repositories/employee_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _tokenKey = "token_info";

  /// Получить информацию об авторизованности сотрудника
  Future<bool> employeeHasBeenLoggedIn() async {
    final storage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storage.deleteAll();
      prefs.setBool('first_run', false);
      return false;
    }
    var str = await storage.read(key: _tokenKey);
    var contains = await storage.containsKey(key: _tokenKey);
    return contains && str != null;
  }

  Future<String> authorizeEmployee(String login, String password) async {
    var user = await EmployeeService().getEmployeeByLogin(login);

    if (user == null) {
      return "error:Сотрудника с таким логином не существует!";
    }

    if (user.password != password) {
      return "error:Пароль введен неверно!";
    }

    await EmployeeRepository().saveEmployeeInfo(user.toJson());
    return "ok";
  }
}
