import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/components/full_screen_view.dart';
import 'package:kupol_app/components/image_select_button.dart';
import 'package:kupol_app/security/components/event_model.dart';
import 'package:kupol_app/security/components/event_status_card.dart';
import 'package:kupol_app/security/components/event_technical_details_card.dart';
import 'package:kupol_app/theme.dart';

class AtWorkEventDetailScreen extends StatelessWidget {
  AtWorkEventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;
  final _messageController = TextEditingController();
  final _imagesFiles = ValueNotifier<List<File?>>([]);
  final _sendMessageNotifier = ValueNotifier<bool>(true);

  void _sendMessage(BuildContext context) {
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
                _sendMessageNotifier.value
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
                      _sendMessageNotifier.value
                          ? "Ваше сообщение успешно отправлено"
                          : "Ваше сообщение не отправлено",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      _sendMessageNotifier.value
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

    _sendMessageNotifier.value = !_sendMessageNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventStatusCard(
                  status: event.status,
                ),
                SizedBox(height: 16),
                Text(
                  event.name,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(
                      "lib/assets/icons/clock.svg",
                    ),
                    SizedBox(width: 8),
                    Text(
                      event.date,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                SizedBox(height: 16),
                EventTechnicalDetailsCard(event: event),
                SizedBox(height: 16),
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 30),
                if (event.images != null)
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: List.generate(
                      event.images!.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenView(
                                  child: Image.asset(
                                    event.images![index],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            event.images![index],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).disabledColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.file(
                                      files[index]!,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
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
                    SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () => _sendMessage(context),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: secondaryColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
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
        ],
      ),
    );
  }
}
