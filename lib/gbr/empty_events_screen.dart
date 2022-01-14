import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyEventsScreen extends StatelessWidget {
  const EmptyEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("lib/assets/empty.svg"),
            SizedBox(height: 60),
            Text(
              "У вас пока нет новых событий",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Как только здесь появится новое событие, вы получите уведомление или создайте событие сами, нажав “+” ниже",
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
