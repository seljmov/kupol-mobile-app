import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/requests/components/request_model.dart';
import 'package:kupol_app/technician/requests/request_technical_details_card.dart';

class RequestDetailScreen extends StatelessWidget {
  RequestDetailScreen({Key? key, required this.request}) : super(key: key);

  final Request request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Подробности заявки"),
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
                  Text(
                    "Заявка #${request.id}",
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
                        request.date,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 16),
                  RequestTechnicalDetailsCard(request: request),
                  SizedBox(height: 16),
                  Text(
                    request.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: kDetailScreenPadding,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Обработать"),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
