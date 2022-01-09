import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/local/employee_service.dart';

class AuthRepository {
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
