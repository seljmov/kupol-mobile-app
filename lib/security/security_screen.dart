import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/profile/profile_screen.dart';
import 'package:kupol_app/security/events_tabs/completed_events_screen.dart';
import 'package:kupol_app/security/events_tabs/new_events_screen.dart';
import 'package:kupol_app/security/events_tabs/work_events_screen.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("События"),
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
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: "Новые"),
              Tab(text: "В работе"),
              Tab(text: "Завершенные"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewEventsScreen(),
            WorkEventsScreen(),
            CompletedEventsScreen(),
          ],
        ),
      ),
    );
  }
}
