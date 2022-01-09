import 'package:kupol_app/components/role.dart';
import 'package:kupol_app/components/employee_model.dart';
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
    Employee(
      id: 1,
      lastname: "Иванов",
      firstname: "Иван",
      patronymic: "Иванович",
      phone: "79887893992",
      address: "Морская ул., 123/5, Москва",
      role: Role.technician,
      pin: "1235",
      login: "test2",
      password: "test",
    ),
  ];

  Future<Employee> getEmployeeById(int id) async {
    return _employees.firstWhere((employee) => employee.id == id);
  }

  Future<Employee?> getEmployeeByLogin(String login) async {
    return _employees.firstWhereOrNull((employee) => employee.login == login);
  }

  Employee getEmployeeByFullname(String fullname) {
    return _employees.firstWhere(
      (employee) => employee.getName() == fullname,
    );
  }
}
