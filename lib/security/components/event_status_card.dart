import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/security/components/event_status.dart';

class EventStatusCard extends StatelessWidget {
  EventStatusCard({Key? key, required this.status}) : super(key: key);

  final EventStatus status;

  Color _getStatusColor(EventStatus status) {
    if (status == EventStatus.New) return kEventNewStatusColor;
    if (status == EventStatus.AtWork) return kEventNewAtWorkColor;
    if (status == EventStatus.OnVerification)
      return kEventOnVerificationStatusColor;
    if (status == EventStatus.Completed) return kEventCompletedStatusColor;
    return kEventNewAtWorkColor;
  }

  String _getStatusName(EventStatus status) {
    if (status == EventStatus.New) return "Новое";
    if (status == EventStatus.AtWork) return "В работе";
    if (status == EventStatus.OnVerification) return "На проверке";
    if (status == EventStatus.Completed) return "Завершено";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getStatusColor(status),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          _getStatusName(status),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
