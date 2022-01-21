import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/gbr/add_event_screen.dart';
import 'package:kupol_app/gbr/empty_events_screen.dart';
import 'package:kupol_app/gbr/event_detail_sreen.dart';
import 'package:kupol_app/profile/profile_screen.dart';
import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/repositories/employee_repository.dart';
import 'package:kupol_app/shared/repositories/events_repository.dart';
import 'package:kupol_app/shared/widgets/event_card.dart';

class GbrScreen extends StatelessWidget {
  const GbrScreen({Key? key}) : super(key: key);

  List<Widget> _configureEventsList({
    required BuildContext context,
    required Map<String, List<Event>> events,
  }) {
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EventCard(
                    event: keyEvents[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(
                            event: keyEvents[index],
                          ),
                        ),
                      );
                    },
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

    return children.isEmpty
        ? [EmptyEventsScreen()]
        : children.reversed.toList();
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
                text: " (10-16 декабря)",
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
                  builder: (context) => ProfileScreen(employee: employee),
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
              child: Text(
                "При получении списка событий что-то пошло не так...",
              ),
            );
          }

          var events = snapshot.data!;
          return SingleChildScrollView(
            padding: kEventsScreenPadding,
            physics: ClampingScrollPhysics(),
            child: Column(
              children: _configureEventsList(
                context: context,
                events: events,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Colors.white,
        elevation: 2,
        child: Icon(
          Icons.add_rounded,
          size: 40,
        ),
      ),
    );
  }
}
