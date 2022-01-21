import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';

class EventStatusCard extends StatelessWidget {
  EventStatusCard({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getEventStatusColor(status),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Text(
          status,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
