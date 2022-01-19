import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/local/employee_service.dart';
import 'package:kupol_app/technician/entity/entity_form/users/components/user_model.dart';

class AuthRepository {
  static const _userInfoKey = "user_info";

  /// Получить информацию об авторизованности пользователя
  Future<bool> userHasBeenLoggedIn() async {
    final storage = FlutterSecureStorage();
    var str = await storage.read(key: _userInfoKey);
    var contains = await storage.containsKey(key: _userInfoKey);
    return contains && str != null;
  }

  /// Сохранить информацию о пользователе
  Future<void> saveUserInfo(User user) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: _userInfoKey);
    await storage.write(key: _userInfoKey, value: user.toRawJson());
  }

  /// Получить информацию о пользователе
  Future<User> getUserInfo() async {
    final storage = FlutterSecureStorage();
    var str = await storage.read(key: _userInfoKey);
    return User.fromRawJson(str!);
  }

  Future<String> authorizeUser(String login, String password) async {
    var user = await EmployeeService().getEmployeeByLogin(login);

    if (user == null) {
      return "error:Пользователя с таким логином не существует!";
    }

    if (user.password != password) {
      return "error:Пароль введен неверно!";
    }

    await EmployeeRepository().saveEmployeeInfo(user.toJson());
    return "ok";
  }
}
