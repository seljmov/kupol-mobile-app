import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/widgets/full_screen_images_carousel.dart';
import 'package:kupol_app/shared/widgets/full_screen_view.dart';
import 'package:kupol_app/shared/widgets/image_selector.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/technician/entity/components/entity_model.dart';
import 'package:kupol_app/technician/entity/entity_form/entity_form_sreen.dart';
import 'package:kupol_app/theme.dart';

class EntityDetailsScreen extends StatelessWidget {
  EntityDetailsScreen({Key? key, required this.entity}) : super(key: key);

  final Entity entity;
  final _editableNotifier = ValueNotifier<bool>(false);
  final _imagesFiles = ValueNotifier<List<MultiImage>>([]);
  final _formFrontSidePhoto = ValueNotifier<MultiImage?>(null);
  final _formBackSidePhoto = ValueNotifier<MultiImage?>(null);

  @override
  Widget build(BuildContext context) {
    _imagesFiles.value = List.of(
      entity.images.map((e) => MultiImage(path: e)),
    );

    if (entity.photo.asMap().containsKey(0))
      _formFrontSidePhoto.value = MultiImage(path: entity.photo[0]);

    if (entity.photo.asMap().containsKey(1))
      _formFrontSidePhoto.value = MultiImage(path: entity.photo[1]);

    return ValueListenableBuilder<bool>(
      valueListenable: _editableNotifier,
      builder: (context, isEditable, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Подробности объекта"),
            leading: Visibility(
              visible: isEditable,
              child: IconButton(
                onPressed: () {
                  _editableNotifier.value = false;
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.redAccent,
                ),
              ),
              replacement: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            actions: [
              Visibility(
                visible: isEditable,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                  ),
                ),
                replacement: IconButton(
                  onPressed: () {
                    _editableNotifier.value = true;
                  },
                  icon: SvgPicture.asset(
                    "lib/assets/icons/pen2.svg",
                    width: 18,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: kDetailScreenPadding,
                  physics: kDefaultPhysics,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "#${entity.id}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Объект: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: !isEditable
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                  ),
                                ),
                                TextSpan(
                                  text: entity.company,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: !isEditable
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Адрес: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: !isEditable
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                  ),
                                ),
                                TextSpan(
                                  text: entity.address,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: !isEditable
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ValueListenableBuilder<List<MultiImage>>(
                        valueListenable: _imagesFiles,
                        builder: (context, images, child) {
                          return GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: List.generate(
                              images.length,
                              (index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return FullScreenImagesCarousel(
                                            currentIndex: index,
                                            images: images,
                                          );
                                        }),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: images[index].path == null
                                          ? Image.file(
                                              images[index].file!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              images[index].path!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isEditable,
                                    child: Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            var newImages = images;
                                            newImages.removeAt(index);
                                            _imagesFiles.value =
                                                List.of(newImages);
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
                                  ),
                                ],
                              ),
                            )..add(
                                Visibility(
                                  visible: isEditable,
                                  child: GestureDetector(
                                    onTap: () async {
                                      var pickFiles = await ImageSeletor()
                                          .select(context: context);
                                      _imagesFiles.value += List.of(pickFiles);
                                    },
                                    child: SvgPicture.asset(
                                      "lib/assets/icons/img_add.svg",
                                      fit: BoxFit.scaleDown,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        "ФОТОГРАФИИ АНКЕТЫ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Присоедините лицевую и обратную сторону анкеты",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          ValueListenableBuilder<MultiImage?>(
                            valueListenable: _formFrontSidePhoto,
                            builder: (context, photo, child) {
                              return Column(
                                children: [
                                  if (photo == null)
                                    GestureDetector(
                                      onTap: () async {
                                        var images =
                                            await ImageSeletor().select(
                                          context: context,
                                          multiFormGallery: false,
                                        );

                                        // Может быть null, если нажали "добавить",
                                        // вышло меню с выбором, а ничего выбрано и добавлено не было
                                        if (images.length > 0) {
                                          _formFrontSidePhoto.value =
                                              images.first;
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "lib/assets/icons/img_add.svg",
                                        color: !isEditable
                                            ? secondaryColor
                                            : hintColor,
                                        fit: BoxFit.scaleDown,
                                        height: 100,
                                      ),
                                    )
                                  else
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (!isEditable) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return FullScreenView(
                                                    child: photo.path == null
                                                        ? Image.file(
                                                            photo.file!,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          )
                                                        : Image.asset(
                                                            photo.path!,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                  );
                                                }),
                                              );
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: photo.path == null
                                                ? Image.file(
                                                    photo.file!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    photo.path!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isEditable,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Лицевая",
                                    style: TextStyle(
                                      color: !isEditable
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(width: 20),
                          ValueListenableBuilder<MultiImage?>(
                            valueListenable: _formBackSidePhoto,
                            builder: (context, photo, child) {
                              return Column(
                                children: [
                                  if (photo == null)
                                    GestureDetector(
                                      onTap: () async {
                                        var images =
                                            await ImageSeletor().select(
                                          context: context,
                                          multiFormGallery: false,
                                        );

                                        // Может быть null, если нажали "добавить",
                                        // вышло меню с выбором, а ничего выбрано и добавлено не было
                                        if (images.length > 0) {
                                          _formBackSidePhoto.value =
                                              images.first;
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "lib/assets/icons/img_add.svg",
                                        color: !isEditable
                                            ? secondaryColor
                                            : hintColor,
                                        fit: BoxFit.scaleDown,
                                        height: 100,
                                      ),
                                    )
                                  else
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (!isEditable) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return FullScreenView(
                                                    child: photo.path == null
                                                        ? Image.file(
                                                            photo.file!,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          )
                                                        : Image.asset(
                                                            photo.path!,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                  );
                                                }),
                                              );
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: photo.path == null
                                                ? Image.file(
                                                    photo.file!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    photo.path!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isEditable,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Обратная",
                                    style: TextStyle(
                                      color: !isEditable
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: kDetailScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: isEditable
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EntityFormScreen(),
                                ),
                              );
                            },
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 19,
                            horizontal: 18,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "lib/assets/icons/doc.svg",
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Анкета объекта",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: !isEditable
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                "lib/assets/icons/right_arrow.svg",
                                color: !isEditable
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color
                                    : hintColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
