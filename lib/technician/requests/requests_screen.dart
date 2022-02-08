import 'package:flutter/material.dart';
import 'package:kupol_app/constants.dart';
import 'package:kupol_app/technician/requests/components/request_card.dart';
import 'package:kupol_app/technician/requests/empty_requests_screen.dart';
import 'package:kupol_app/technician/requests/components/request_model.dart';
import 'package:kupol_app/technician/repositories/technician_repository.dart';
import 'package:kupol_app/technician/requests/request_detail_screen.dart';

class RequestsScreen extends StatelessWidget {
  RequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Request>>(
      future: TechnicianRepository().getRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("При получении списка заявок что-то пошло не так..."),
          );
        }

        var requests = snapshot.data!;
        if (requests.isEmpty) return EmptyRequestsScreen();
        return SingleChildScrollView(
          padding: kEventsScreenPadding,
          physics: kDefaultPhysics,
          child: Column(
            children: List.generate(requests.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RequestDetailScreen(
                          request: requests[index],
                        ),
                      ),
                    );
                  },
                  child: RequestCard(
                    request: requests[index],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
