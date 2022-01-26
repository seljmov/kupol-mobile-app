import 'package:flutter/material.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/full_screen_images_carousel.dart';
import 'package:kupol_app/shared/models/event_model.dart';

class EventLog extends StatelessWidget {
  EventLog({Key? key, required this.event}) : super(key: key);

  final Event event;
  final _logImages = [
    "lib/assets/images/journal1.png",
    "lib/assets/images/journal2.png"
  ];

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
        SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          children: List.generate(
            _logImages.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImagesCarousel(
                        currentIndex: index,
                        images: List<MultiImage>.of(
                          _logImages.map((e) => MultiImage(path: e)),
                        ),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  _logImages[index],
                ),
              );
            },
          ),
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
