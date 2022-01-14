import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/profile/profile_screen.dart';
import 'package:kupol_app/security/components/event_card.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/repositories/events_repository.dart';

class EventsScreenGbr extends StatelessWidget {
  const EventsScreenGbr({Key? key}) : super(key: key);

  List<Widget> _configureEventsList(Map<String, List<Event>> events) {
    List<Widget> children = [];

    for (var key in events.keys) {
      var keyEvents = events[key]!;
      var widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              bottom: 8,
            ),
            child: Text(
              key.toUpperCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: List.generate(
              keyEvents.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EventCard(
                    event: keyEvents[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      );

      children.add(widget);
    }

    return children.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "События",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: " (10-15 декабря)",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              var employee = await EmployeeRepository().getEmployeeInfo();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(employee: employee!),
                ),
              );
            },
            child: SvgPicture.asset(
              "lib/assets/icons/user.svg",
              color: Theme.of(context).textTheme.headline6?.color,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<Event>>>(
        future: EventsRepository().getEventsByDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child:
                  Text("При получении списка событий что-то пошло не так..."),
            );
          }

          var events = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: _configureEventsList(events),
              ),
            ),
          );
        },
      ),
    );
  }
}
