import 'package:flutter/material.dart';
import 'package:kupol_app/technician/entity/components/entity_card.dart';
import 'package:kupol_app/technician/entity/empty_entities_screen.dart';
import 'package:kupol_app/technician/entity/components/entity_model.dart';
import 'package:kupol_app/technician/repositories/technician_repository.dart';

class EntitiesScreen extends StatelessWidget {
  const EntitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Entity>>(
      future: TechnicianRepository().getEntities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("При получении списка объектов что-то пошло не так..."),
          );
        }

        var entities = snapshot.data!;
        if (entities.isEmpty) return EmptyEntitiesScreen();
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: List.generate(entities.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: EntityCard(
                  entity: entities[index],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
