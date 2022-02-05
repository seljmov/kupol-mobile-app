import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/attach_images_grid.dart';
import 'package:kupol_app/theme.dart';

void sendMessage({
  required BuildContext context,
  required bool isSuccess,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              isSuccess
                  ? "lib/assets/icons/success.svg"
                  : "lib/assets/icons/error.svg",
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isSuccess
                        ? "Ваше сообщение успешно отправлено"
                        : "Ваше сообщение не отправлено",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    isSuccess
                        ? "Ожидайте ответа оператора"
                        : "Произошла какая-то ошибка",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> showSendMessageBottomSheet({
  required BuildContext context,
}) async {
  final _messageController = TextEditingController();
  final _imagesFiles = ValueNotifier<List<MultiImage>>([]);
  final random = Random().nextInt(5);
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: GestureDetector(
        onTap: () => catchFocus(context),
        child: Padding(
          padding: kDetailScreenPadding,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom / 1.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Center(
                  child: SvgPicture.asset(
                    "lib/assets/icons/drop_down.svg",
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "Введите текст сообщения",
                    labelText: "Сообщение для оператора",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
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
                SizedBox(height: 30),
                AttachImagesGrid(imagesNotifier: _imagesFiles),
                SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      sendMessage(
                        context: context,
                        isSuccess: random >= 1,
                      );
                    },
                    style: kNotPrimaryButtonTheme,
                    child: Text(
                      "Отправить сообщение",
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
