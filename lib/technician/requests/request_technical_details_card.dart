import 'package:flutter/material.dart';
import 'package:kupol_app/technician/requests/components/request_model.dart';

class RequestTechnicalDetailsCard extends StatelessWidget {
  RequestTechnicalDetailsCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final Request request;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Объект: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: request.company,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
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
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: request.address,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
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
                text: "Менеджер: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: request.manager,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
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
                text: "Высокий приоритет: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: request.highPriority ? "Да" : "Нет",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
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
                text: "Создатель: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: request.creatorName,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
