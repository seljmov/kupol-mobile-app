import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/security/widgets/event_log.dart';
import 'package:kupol_app/shared/widgets/event_technical_details_card.dart';
import 'package:kupol_app/security/widgets/send_message_bottom_sheet.dart';
import 'package:kupol_app/shared/models/event_model.dart';
import 'package:kupol_app/shared/models/event_status.dart';
import 'package:kupol_app/shared/widgets/event_status_card.dart';
import 'package:kupol_app/shared/widgets/images_grid_view.dart';
import 'package:kupol_app/theme.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => catchFocus(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Подробности события"),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: kDetailScreenPadding,
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    ImagesGridView(images: event.images),
                    Visibility(
                      visible: event.images != null,
                      child: SizedBox(height: 30),
                    ),
                    Visibility(
                      visible: event.status != EventStatus.New,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: EventLog(event: event),
                      ),
                    ),
                    Visibility(
                      visible: event.status == EventStatus.OnVerification ||
                          event.status == EventStatus.InWork,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () async {
                              await showSendMessageBottomSheet(
                                context: context,
                                event: event,
                              );
                            },
                            style: kNotPrimaryButtonTheme,
                            child: Text(
                              "Добавить сообщение",
                              style: TextStyle(
                                fontSize: 16,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: kDetailScreenPadding,
              child: Visibility(
                visible: event.status == EventStatus.New,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Взять в работу"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
