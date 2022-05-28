import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyRequestsScreen extends StatelessWidget {
  const EmptyRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("lib/assets/empty.svg"),
            SizedBox(height: 60),
            Text(
              "У вас пока нет новых заявок",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Как только здесь появится новая заявка, вы получите уведомление",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyText2?.color,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
