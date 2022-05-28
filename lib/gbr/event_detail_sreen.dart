import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/widgets/event_technical_details_card.dart';
import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/widgets/images_grid_view.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Подробности события"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
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
            ImagesGridView(images: event.images),
          ],
        ),
      ),
    );
  }
}
