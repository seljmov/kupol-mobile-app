import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/theme.dart';

class DefaultProfileAvatar extends StatelessWidget {
  const DefaultProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: secondaryColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          "lib/assets/icons/user.svg",
          width: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}
