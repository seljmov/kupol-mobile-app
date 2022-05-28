import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/security/event_detail_screen.dart';
import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/repositories/events_repository.dart';
import 'package:kupol_app/shared/widgets/event_card.dart';

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
        return SingleChildScrollView(
          padding: kEventsScreenPadding,
          physics: kDefaultPhysics,
          child: Column(
            children: List.generate(events.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
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
          ),
        );
      },
    );
  }
}
