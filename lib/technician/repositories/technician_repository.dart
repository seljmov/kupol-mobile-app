import 'package:kupol_app/technician/entity/components/entity_model.dart';
import 'package:kupol_app/technician/requests/components/request_model.dart';

class TechnicianRepository {
  final List<Request> _requests = [
    Request(
      id: 4784,
      company: "ООО Зеленые сады",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
      manager: "Батырбеков Рашид",
      highPriority: true,
      creatorName: "Баранов Андрей",
      description:
          "Необходимо запрограммировать дополнительные ключи ТМ и для домофона на втором этаже. Ключи отдать Алине.",
      date: "15.12.2021, 19:43",
    ),
    Request(
      id: 4785,
      company: "Фитнес-клуб “Fit Star”",
      address: "Куликова ул., 28, Москва",
      manager: "Батырбеков Рашид",
      highPriority: false,
      creatorName: "Баранов Андрей",
      description: "Необходимо запрограммировать дополнительные ключи ТМ.",
      date: "15.12.2021, 19:43",
    ),
  ];

  final List<Entity> _entities = [
    Entity(
      id: 916,
      company: "ООО Зеленые сады",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
      images: [
        "lib/assets/images/img_green1.png",
        "lib/assets/images/img_green2.png",
      ],
      photo: [],
    ),
    Entity(
      id: 870,
      company: "Фитнес-клуб “Fit Star”",
      address: "Куликова ул., 28, Москва",
      images: [],
      photo: [],
    ),
    Entity(
      id: 917,
      company: "СОШ 1",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
      images: [],
      photo: [],
    ),
    Entity(
      id: 871,
      company: "СОШ №2",
      address: "Куликова ул., 28, Москва",
      images: [],
      photo: [],
    ),
    Entity(
      id: 918,
      company: "ООО Царские пруды",
      address: "Б. Грузинская ул., 32 строение 10, Москва",
      images: [],
      photo: [],
    ),
    Entity(
      id: 872,
      company: "СОШ №3",
      address: "Куликова ул., 28, Москва",
      images: [],
      photo: [],
    ),
  ];

  Future<List<Request>> getRequests() async {
    return _requests;
  }

  Future<List<Entity>> getEntities() async {
    return _entities;
  }
}
