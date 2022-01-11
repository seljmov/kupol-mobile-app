import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/full_screen_view.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status_card.dart';
import 'package:kupol_app/security/components/event_technical_details_card.dart';

class CompletedEventDetailScreen extends StatelessWidget {
  CompletedEventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EventStatusCard(
            status: event.status,
          ),
          SizedBox(height: 16),
          Text(
            event.name,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontWeight: FontWeight.w600,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
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
            ),
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
