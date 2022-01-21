import 'package:flutter/material.dart';
import 'package:kupol_app/security/event_detail_screen.dart';
import 'package:kupol_app/shared/events_repository.dart';
import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/widgets/event_card.dart';

class NewEventsScreen extends StatelessWidget {
  const NewEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: EventsRepository().getNewEvents(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(
                        event: events[index],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}
