import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/components/image_select_button.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/shared/models/event_model.dart';
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
  required Event event,
}) async {
  final _messageController = TextEditingController();
  final _imagesFiles = ValueNotifier<List<File?>>([]);
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
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.file(
                              files[index]!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
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
  );
}
