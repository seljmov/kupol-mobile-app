import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/entity/entity_form/repositories/entity_form_repository.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/components/section_model.dart';
import 'package:kupol_app/technician/entity/entity_form/sections/section_details_screen.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  Future<void> _showMoreBottomSheet({
    required BuildContext context,
    required Section section,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Center(
            child: SvgPicture.asset(
              "lib/assets/icons/drop_down.svg",
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text(
                    "Редактировать",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SectionDetailsScreen(
                          section: section,
                        ),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text(
                    "Удалить",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Section>>(
      future: EntityFormRepository().getSections(),
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

        var sections = snapshot.data!;
        return SingleChildScrollView(
          physics: kDefaultPhysics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(sections.length, (index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                sections[index].id.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color,
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      sections[index].location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            _showMoreBottomSheet(
                              context: context,
                              section: sections[index],
                            );
                          },
                          icon: SvgPicture.asset(
                            "lib/assets/icons/more.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
