import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/gbr/bottom_sheet_picker.dart';
import 'package:kupol_app/shared/widgets/full_screen_view.dart';
import 'package:kupol_app/shared/components/image_select_button.dart';
import 'package:kupol_app/constants.dart';

class AddEventScreen extends StatelessWidget {
  AddEventScreen({Key? key}) : super(key: key);

  final _eventTitles = [
    "Распитие спиртных напитков",
    "Разведение открытого огня в неположенном месте",
    "Работоспособность камеры видеонаблюдения",
  ];

  final _eventCategories = [
    "Нарушение режима (территория строительства)",
    "Вандальные действия, повреждение и порча имущества",
  ];

  final _canCreateEventNotifier = ValueNotifier<bool>(false);
  final _eventTitleController = TextEditingController();
  final _eventCategoryController = TextEditingController();
  final _eventAddressController = TextEditingController();
  final _eventDescController = TextEditingController();
  final _imagesFiles = ValueNotifier<List<File?>>([]);

  bool _verifyAbilityToCreateAnEvent() {
    return _eventTitleController.text.isNotEmpty &&
        _eventCategoryController.text.isNotEmpty &&
        _eventAddressController.text.isNotEmpty &&
        _eventDescController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => catchFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Новое событие"),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close_rounded,
            ),
          ),
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: _canCreateEventNotifier,
              builder: (context, canCreate, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: !canCreate ? null : () => Navigator.pop(context),
                    child: Icon(
                      Icons.check_rounded,
                      color: !canCreate
                          ? Theme.of(context).textTheme.bodyText2?.color
                          : Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: kDetailScreenPadding,
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                onTap: () async {
                  await BottomSheetPicker.pick(
                    context: context,
                    onTapItem: (title) {
                      if (title != null) {
                        _eventTitleController.text = title;
                      }
                    },
                    items: _eventTitles,
                  );
                  _canCreateEventNotifier.value =
                      _verifyAbilityToCreateAnEvent();
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: _eventTitleController,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Событие",
                  hintText: "Выберите событие",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "lib/assets/icons/arrow_down.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onTap: () async {
                  await BottomSheetPicker.pick(
                    context: context,
                    onTapItem: (title) {
                      if (title != null) {
                        _eventCategoryController.text = title;
                      }
                    },
                    items: _eventCategories,
                  );
                  _canCreateEventNotifier.value =
                      _verifyAbilityToCreateAnEvent();
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: _eventCategoryController,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Категория",
                  hintText: "Выберите категорию",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "lib/assets/icons/arrow_down.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  _canCreateEventNotifier.value =
                      _verifyAbilityToCreateAnEvent();
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                controller: _eventAddressController,
                decoration: const InputDecoration(
                  hintText: "Введите адрес",
                  labelText: "Адрес",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  _canCreateEventNotifier.value =
                      _verifyAbilityToCreateAnEvent();
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                obscureText: true,
                controller: _eventDescController,
                decoration: const InputDecoration(
                  hintText: "Введите описание",
                  labelText: "Описание",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "ФОТОГРАФИИ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Присоедините не более 5 фото",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<List<File?>>(
                valueListenable: _imagesFiles,
                builder: (context, files, child) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: List.generate(
                      files.length,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenView(
                                    child: Image.file(
                                      files[index]!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                files[index]!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  var newfiles = files;
                                  newfiles.removeAt(index);
                                  _imagesFiles.value = List.of(newfiles);
                                },
                                child: SvgPicture.asset(
                                  "lib/assets/icons/button_delete.svg",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )..add(ImageSelectButton(imagesFiles: _imagesFiles)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
