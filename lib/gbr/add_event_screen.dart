import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/gbr/bottom_sheet_picker.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/attach_images_grid.dart';
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
  final _imagesFiles = ValueNotifier<List<MultiImage>>([]);

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
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close_rounded,
              color: Colors.redAccent,
            ),
          ),
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: _canCreateEventNotifier,
              builder: (context, canCreate, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: !canCreate ? null : () => Navigator.pop(context),
                    icon: Icon(
                      Icons.check_rounded,
                      color: !canCreate
                          ? Theme.of(context).textTheme.bodyText2?.color
                          : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: kDetailScreenPadding,
          physics: kDefaultPhysics,
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
              AttachImagesGrid(imagesNotifier: _imagesFiles),
            ],
          ),
        ),
      ),
    );
  }
}
