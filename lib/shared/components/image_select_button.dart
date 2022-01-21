import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/widgets/image_selector.dart';

class ImageSelectButton extends StatelessWidget {
  ImageSelectButton({Key? key, required this.imagesFiles}) : super(key: key);

  final ValueNotifier<List<File?>> imagesFiles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var file = await ImageSeletor().select(context);

        // Может быть null, если нажали "добавить",
        // вышло меню с выбором, а ничего выбрано и добавлено не было
        if (file != null) {
          var files = imagesFiles.value;
          imagesFiles.value = List.of(files)..add(file);
        }
      },
      child: SvgPicture.asset(
        "lib/assets/icons/img_add.svg",
        fit: BoxFit.scaleDown,
        height: 100,
      ),
    );
  }
}
