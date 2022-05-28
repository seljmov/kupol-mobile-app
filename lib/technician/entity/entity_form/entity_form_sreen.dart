import 'package:flutter/material.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/plume_details_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/plumes_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/section_details_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/sections_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/users/user_details_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/users/users_screen.dart';

class PageIndex {
  static const int UsersPage = 0;
  static const int SectionsPage = 1;
  static const int PlumsPage = 2;
}

class EntityFormScreen extends StatefulWidget {
  EntityFormScreen({Key? key}) : super(key: key);

  @override
  State<EntityFormScreen> createState() => _EntityFormScreenState();
}

class _EntityFormScreenState extends State<EntityFormScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Анкета объекта"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: "Пользователи"),
              Tab(text: "Разделы"),
              Tab(text: "Шлейфы"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              UsersScreen(),
              SectionsScreen(),
              PlumesScreen(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var index = _tabController.index;
            Widget detailsScreen = UserDetailsScreen();
            if (index == PageIndex.UsersPage)
              detailsScreen = UserDetailsScreen();
            if (index == PageIndex.SectionsPage)
              detailsScreen = SectionDetailsScreen();
            if (index == PageIndex.PlumsPage)
              detailsScreen = PlumeDetailsScreen();

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => detailsScreen,
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
      ),
    );
  }
}
