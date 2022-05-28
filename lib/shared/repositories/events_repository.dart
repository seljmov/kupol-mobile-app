import 'dart:collection';
import 'dart:core';

import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/models/event_status.dart';

class EventsRepository {
  List<Event> _events = [
    Event(
      id: 0,
      creatorName: "Иванов И.И.",
      status: EventStatus.New,
      name: "Распитие спиртных напитков",
      category: "Нарушение режима (территория строительства)",
      address: "ООО Зеленые сады",
      description: "Сотрудник распивает алкоголь на территории строительства",
      date: "15.12.2021, 20:31",
      images: [
        "lib/assets/images/img1.png",
      ],
    ),
    Event(
      id: 1,
      creatorName: "Иванов И.И.",
      status: EventStatus.New,
      name: "Разведение открытого огня в неположенном месте",
      category: "Нарушение режима (территория строительства)",
      address: "ООО Царские пруды",
      description: "Сотрудник сжег бумагу в кабинете в урне",
      date: "13.12.2021, 19:15",
    ),
    Event(
      id: 2,
      creatorName: "Иванов И.И.",
      executorName: "Селимов З.М.",
      status: EventStatus.InWork,
      name: "Работоспособность камеры видеонаблюдения",
      category: "Вандальные действия, повреждение и порча имущества",
      address: "ООО Зеленые сады",
      description:
          "Необходимо проверить работоспособность камер видеонаблюдения на территории локации",
      date: "13.12.2021, 15:22",
      images: [
        "lib/assets/images/img_camera1.png",
        "lib/assets/images/img_camera2.png",
      ],
    ),
    Event(
      id: 3,
      creatorName: "Иванов И.И.",
      executorName: "Селимов З.М.",
      status: EventStatus.OnVerification,
      name: "Распитие спиртных напитков",
      category: "Нарушение режима (территория строительства)",
      address: "ООО Зеленые сады",
      description: "Сотрудник распивает алкоголь на территории строительства",
      date: "11.12.2021, 19:43",
      images: [
        "lib/assets/images/img1.png",
      ],
    ),
    Event(
      id: 4,
      creatorName: "Иванов И.И.",
      executorName: "Селимов З.М.",
      status: EventStatus.Completed,
      name: "Распитие спиртных напитков",
      category: "Нарушение режима (территория строительства)",
      address: "ООО Зеленые сады",
      description: "Сотрудник распивает алкоголь на территории строительства",
      date: "16.12.2021, 19:43",
      images: [
        "lib/assets/images/img1.png",
      ],
    ),
  ];

  Future<List<Event>> getNewEvents() async {
    var events = _events.where((event) => event.status == EventStatus.New);
    return events.toList();
  }

  Future<List<Event>> getWorkEvents() async {
    var events = _events.where(
      (event) =>
          event.status == EventStatus.InWork ||
          event.status == EventStatus.OnVerification,
    );
    return events.toList();
  }

  Future<List<Event>> getCompletedEvents() async {
    var events = _events.where(
      (event) => event.status == EventStatus.Completed,
    );
    return events.toList();
  }

  Future<Map<String, List<Event>>> getEventsByDate() async {
    var monthByNumber = [
      "Января",
      "Февраля",
      "Марта",
      "Апреля",
      "Мая",
      "Июня",
      "Июля",
      "Августа",
      "Сентября",
      "Октября",
      "Ноября",
      "Декабря"
    ];
    var events = SplayTreeMap<String, List<Event>>();

    _events.forEach((event) {
      var date = event.date.split(",")[0];
      var day = date.split(".")[0];
      var month = int.parse(date.split(".")[1]);
      var dateKey = "$day ${monthByNumber[month - 1]}";
      if (events.containsKey(dateKey)) {
        events[dateKey]?.add(event);
      } else {
        events[dateKey] = [event];
      }
    });

    return events;
  }
}
