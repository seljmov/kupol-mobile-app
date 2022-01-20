import 'package:flutter/material.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/create_plume_bottom_sheet.dart';
import 'package:kupol_app/technician/entity/entity_form/plumes/plumes_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/create_section_bottom_sheet.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/sections_screen.dart';
import 'package:kupol_app/technician/entity/entity_form/users/create_user_bottom_sheet.dart';
import 'package:kupol_app/technician/entity/entity_form/users/users_screen.dart';

class PageIndex {
  static const int UsersPage = 0;
  static const int SectionsPage = 1;
  static const int PlumsPage = 2;
}

class EntityFormScreen extends StatelessWidget {
  EntityFormScreen({Key? key}) : super(key: key);

  final _activeTabNotifier = ValueNotifier<int>(0);

  Future<void> _getCreateFunction(BuildContext context) async {
    var index = _activeTabNotifier.value;
    if (index == PageIndex.UsersPage) {
      await showCreateUserBottomSheet(context: context);
    }
    if (index == PageIndex.SectionsPage) {
      await showCreateSectionBottomSheet(context: context);
    }
    if (index == PageIndex.PlumsPage) {
      await showCreatePlumeBottomSheet(context: context);
    }

    return null;
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
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: "Пользователи"),
              Tab(text: "Разделы"),
              Tab(text: "Шлейфы"),
            ],
            onTap: (index) {
              _activeTabNotifier.value = index;
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: TabBarView(
            children: [
              UsersScreen(),
              SectionsScreen(),
              PlumesScreen(),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: _activeTabNotifier,
          builder: (context, value, child) {
            return FloatingActionButton(
              onPressed: () async => await _getCreateFunction(context),
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              foregroundColor: Colors.white,
              elevation: 2,
              child: Icon(
                Icons.add_rounded,
                size: 40,
              ),
            );
          },
        ),
      ),
    );
  }
}
