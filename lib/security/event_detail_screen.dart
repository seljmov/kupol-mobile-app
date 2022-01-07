import 'package:flutter/material.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status.dart';
import 'package:kupol_app/security/event_detail_screens/at_work_event_detail_screen.dart';
import 'package:kupol_app/security/event_detail_screens/completed_event_detail_screen.dart';
import 'package:kupol_app/security/event_detail_screens/new_event_detail_screen.dart';
import 'package:kupol_app/security/event_detail_screens/on_verif_event_detail_screen.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  Widget _getScreenByStatus(Event event) {
    if (event.status == EventStatus.New) {
      return NewEventDetailScreen(
        event: event,
      );
    }

    if (event.status == EventStatus.AtWork)
      return AtWorkEventDetailScreen(
        event: event,
      );
    if (event.status == EventStatus.OnVerification)
      return OnVerificationEventDetailScreen(
        event: event,
      );
    if (event.status == EventStatus.Completed)
      return CompletedEventDetailScreen(
        event: event,
      );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Подробности события",
        ),
      ),
      body: _getScreenByStatus(event),
    );
  }
}
