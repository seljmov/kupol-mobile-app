import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_model.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/local/employee_service.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status.dart';

class EventCard extends StatelessWidget {
  EventCard({Key? key, required this.event}) : super(key: key);

  final Event event;

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

  String _smartSubstring(String source, int length) {
    if (source.length <= length) return source;

    source = source.substring(0, length);
    source += "...";

    return source;
  }

  String _getSubtitle() {
    return event.status == EventStatus.New
        ? event.address
        : "${event.address}, ${event.executorName}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "lib/assets/icons/clock.svg",
                    ),
                    SizedBox(width: 8),
                    Text(event.date),
                    SizedBox(width: 8),
                    Card(
                      elevation: 0,
                      color: _getStatusColor(event.status),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          _getStatusName(event.status),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _smartSubstring(event.name, 30),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SvgPicture.asset(
                      "lib/assets/icons/right_arrow.svg",
                    ),
                  ],
                ),
                Text(
                  _getSubtitle(),
                ),
              ],
            ),
            if (event.status == EventStatus.New)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Взять в работу"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
