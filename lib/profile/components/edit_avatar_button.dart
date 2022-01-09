import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditAvatarButton extends StatelessWidget {
  const EditAvatarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          "lib/assets/icons/pen.svg",
        ),
      ),
    );
  }
}
