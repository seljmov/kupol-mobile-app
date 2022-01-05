import 'package:kupol_app/components/role.dart';
import 'package:kupol_app/components/Employee_model.dart';
import 'package:collection/collection.dart';

class EmployeeService {
  List<Employee> _employees = [
    Employee(
      id: 0,
      lastname: "Селимов",
      firstname: "Загир",
      patronymic: "Мурадович",
      phone: "79887893991",
      address: "Морская ул., 123/5, Москва",
      role: Role.security,
      pin: "1234",
      login: "test",
      password: "test",
    ),
  ];

  Future<Employee?> getEmployeeByLogin(String login) async {
    return _employees.firstWhereOrNull((employee) => employee.login == login);
  }
}
