import 'package:kupol_app/components/role.dart';
import 'package:kupol_app/components/user_model.dart';

class UserService {
  List<User> _users = [
    User(
      id: 0,
      lastname: "Васильев",
      firstname: "Николай",
      patronymic: "Андреевич",
      phone: "79255669071",
      address: "Морская ул., 123/5, Москва",
      role: Role.security,
      pin: "5567",
    ),
    User(
      id: 1,
      lastname: "Бекмамбетов",
      firstname: "Валентин",
      patronymic: "Михайлович",
      phone: "79255669071",
      address: "Большая сенная ул., 24 стр. 1, Москва",
      role: Role.security,
      pin: "9876",
    ),
    User(
      id: 2,
      lastname: "Алексеева",
      firstname: "Юлия",
      patronymic: "Валерьевна",
      phone: "79255669071",
      address: "Морская ул., 123/5, Москва",
      role: Role.security,
      pin: "1234",
    ),
  ];

  Future<User> getUserInfoById(int id) async {
    return _users.firstWhere((user) => user.id == id);
  }
}
