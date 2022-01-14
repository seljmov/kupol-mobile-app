import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status.dart';
import 'package:kupol_app/security/components/event_status_card.dart';
import 'package:kupol_app/security/event_detail_screen.dart';

// TODO: Создать общий EventsScrollList
class EventCard extends StatelessWidget {
  EventCard({
    Key? key,
    required this.event,
    this.showStatus,
    this.showButtons,
  }) : super(key: key);

  final Event event;
  final bool? showStatus;
  final bool? showButtons;

  String _getSubtitle() {
    return event.status == EventStatus.New
        ? event.address
        : "${event.address}, ${event.executorName}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Card(
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
                      Text(
                        event.date,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (showStatus == true)
                        EventStatusCard(status: event.status),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        "lib/assets/icons/right_arrow.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    _getSubtitle(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                ],
              ),
              if (event.status == EventStatus.New && showButtons == true)
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
      ),
    );
  }
}
