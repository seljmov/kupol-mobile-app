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
      login: "testsec",
      password: "testsec",
    ),
    Employee(
      id: 1,
      lastname: "Антонов",
      firstname: "Алексей",
      patronymic: "Максимович",
      phone: "79887887415",
      address: "Морская ул., 123/5, Москва",
      role: Role.gbr,
      pin: "1234",
      login: "testgbr",
      password: "testgbr",
    ),
    Employee(
      id: 2,
      lastname: "Иванов",
      firstname: "Иван",
      patronymic: "Иванович",
      phone: "79887874521",
      address: "Морская ул., 123/5, Москва",
      role: Role.technician,
      pin: "1235",
      login: "testtech",
      password: "testtech",
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
