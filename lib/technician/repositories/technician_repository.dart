import 'package:kupol_app/technician/entity/components/entity_model.dart';
import 'package:kupol_app/technician/requests/components/request_model.dart';

class TechnicianRepository {
  final List<Request> _requests = [
    Request(
      id: 4784,
      company: "ООО Зеленые сады",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
      date: "15.12.2021, 19:43",
    ),
    Request(
      id: 4785,
      company: "Фитнес-клуб “Fit Star”",
      address: "Куликова ул., 28, Москва",
      date: "15.12.2021, 19:43",
    ),
  ];

  final List<Entity> _entities = [
    Entity(
      id: 916,
      company: "ООО Зеленые сады",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
    ),
    Entity(
      id: 870,
      company: "Фитнес-клуб “Fit Star”",
      address: "Куликова ул., 28, Москва",
    ),
    Entity(
      id: 917,
      company: "СОШ 1",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
    ),
    Entity(
      id: 871,
      company: "СОШ №2",
      address: "Куликова ул., 28, Москва",
    ),
    Entity(
      id: 918,
      company: "ООО Царские пруды",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
    ),
    Entity(
      id: 872,
      company: "СОШ №3",
      address: "Куликова ул., 28, Москва",
    ),
  ];

  Future<List<Request>> getRequests() async {
    return _requests;
  }

  Future<List<Entity>> getEntities() async {
    return _entities;
  }
}
