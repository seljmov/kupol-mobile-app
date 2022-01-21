import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/employee_repository.dart';
import 'package:kupol_app/profile/profile_screen.dart';
import 'package:kupol_app/technician/entity/entities_screen.dart';
import 'package:kupol_app/technician/requests/requests_screen.dart';

class TechnicianScreen extends StatelessWidget {
  TechnicianScreen({Key? key}) : super(key: key);

  final _activeTabNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: ValueListenableBuilder<int>(
            valueListenable: _activeTabNotifier,
            builder: (context, index, child) {
              return Text(index == 0 ? "Заявки" : "Объекты");
            },
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
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: "Заявки"),
              Tab(text: "Объекты"),
            ],
            onTap: (index) {
              _activeTabNotifier.value = index;
            },
          ),
        ),
        body: TabBarView(
          children: [
            RequestsScreen(),
            EntitiesScreen(),
          ],
        ),
      ),
    );
  }
}
