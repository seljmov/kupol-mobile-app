import 'package:flutter/material.dart';
import 'package:kupol_app/components/full_screen_view.dart';
import 'package:kupol_app/shared/models/event_model.dart';

class EventLog extends StatelessWidget {
  EventLog({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 30),
        Text(
          "ЖУРНАЛ СОБЫТИЙ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "${event.date}, ${event.executorName}",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 20),
        Text(
          "Нарушитель задержан и передан правоохранительным органом. Составлен акт.",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenView(
                      child: Image.asset(
                        "lib/assets/images/journal1.png",
                      ),
                    ),
                  ),
                );
              },
              child: Image.asset(
                "lib/assets/images/journal1.png",
              ),
            ),
            SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenView(
                      child: Image.asset(
                        "lib/assets/images/journal2.png",
                      ),
                    ),
                  ),
                );
              },
              child: Image.asset(
                "lib/assets/images/journal2.png",
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          "26.12.2021, 20:32, ${event.creatorName}",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 20),
        Text(
          "Ок. Принято.",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
