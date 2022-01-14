import 'package:flutter/material.dart';
import 'package:kupol_app/security/components/event_card.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/repositories/events_repository.dart';

class WorkEventsScreen extends StatelessWidget {
  const WorkEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: EventsRepository().getWorkEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("При получении списка событий что-то пошло не так..."),
          );
        }

        var events = snapshot.data!;
        return Column(
          children: List.generate(events.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventCard(
                event: events[index],
                showStatus: true,
                showButtons: true,
              ),
            );
          }),
        );
      },
    );
  }
}
