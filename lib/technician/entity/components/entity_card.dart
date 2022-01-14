import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/technician/entity/components/entity_model.dart';

class EntityCard extends StatelessWidget {
  EntityCard({Key? key, required this.entity}) : super(key: key);

  final Entity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "#${entity.id}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        "lib/assets/icons/right_arrow.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    entity.company,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    entity.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
