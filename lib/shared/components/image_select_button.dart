import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/image_selector.dart';

class ImageSelectButton extends StatelessWidget {
  ImageSelectButton({Key? key, required this.imagesFiles}) : super(key: key);

  final ValueNotifier<List<MultiImage>> imagesFiles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var pickFiles = await ImageSeletor().select(context);
        imagesFiles.value += List.of(pickFiles);
      },
      child: SvgPicture.asset(
        "lib/assets/icons/img_add.svg",
        fit: BoxFit.scaleDown,
        height: 100,
      ),
    );
  }
}
