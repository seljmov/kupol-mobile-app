import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/full_screen_view.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status_card.dart';
import 'package:kupol_app/security/components/event_technical_details_card.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Подробности события"),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              event.category,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
            SizedBox(height: 16),
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
              ],
            ),
            SizedBox(height: 16),
            EventTechnicalDetailsCard(event: event),
            SizedBox(height: 16),
            Text(
              event.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),
            if (event.images != null)
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                  event.images!.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenView(
                              child: Image.asset(
                                event.images![index],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        event.images![index],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
