import 'package:kupol_app/shared/models/user_role.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/components/plume_model.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/components/section_model.dart';
import 'package:kupol_app/technician/entity/entity_form/users/components/user_model.dart';

class EntityFormRepository {
  List<User> _users = [
    User(
      id: 0,
      lastname: "Васильев",
      firstname: "Николай",
      patronymic: "Андреевич",
      phone: "79255669071",
      address: "Морская ул., 123/5, Москва",
      role: UserRole.Security,
      pin: "5567",
    ),
    User(
      id: 1,
      lastname: "Бекмамбетов",
      firstname: "Валентин",
      patronymic: "Михайлович",
      phone: "79255669071",
      address: "Большая сенная ул., 24 стр. 1, Москва",
      role: UserRole.Security,
      pin: "9876",
    ),
    User(
      id: 2,
      lastname: "Алексеева",
      firstname: "Юлия",
      patronymic: "Валерьевна",
      phone: "79255669071",
      address: "Морская ул., 123/5, Москва",
      role: UserRole.Security,
      pin: "1234",
    ),
  ];

  List<Section> _sections = [
    Section(
      id: 1,
      location: "любой",
    ),
    Section(
      id: 2,
      location: "Шкаф серверный",
    ),
    Section(
      id: 3,
      location: "Банкомат+терминал",
    ),
  ];

  List<Plume> _plumes = [
    Plume(
      id: 1,
      location: "любой",
    ),
    Plume(
      id: 2,
      location: "Шкаф серверный",
    ),
    Plume(
      id: 3,
      location: "Банкомат+терминал",
    ),
  ];

  Future<List<User>> getUsers() async {
    return _users;
  }

  Future<List<Section>> getSections() async {
    return _sections;
  }

  Future<List<Plume>> getPlumes() async {
    return _plumes;
  }
}
