import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/local/employee_service.dart';
import 'package:kupol_app/security/components/event_model.dart';

class EventTechnicalDetailsCard extends StatelessWidget {
  EventTechnicalDetailsCard({Key? key, required this.event}) : super(key: key);

  final Event event;

  String getExecutorRoleName(String executorName) {
    var user = EmployeeService().getEmployeeByFullname(executorName);

    return user == null ? "" : getRoleName(user.role);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Локация: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: event.address,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (event.executorName != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Взял в работу: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                  TextSpan(
                    text:
                        "${event.executorName} (${getExecutorRoleName(event.executorName!)})",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Оператор: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
              TextSpan(
                text: event.creatorName,
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
