import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kupol_app/shared/components/image_select_button.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/full_screen_images_carousel.dart';

class AttachImagesGrid extends StatelessWidget {
  AttachImagesGrid({
    Key? key,
    required this.imagesNotifier,
  }) : super(key: key);

  final ValueNotifier<List<MultiImage>> imagesNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MultiImage>>(
      valueListenable: imagesNotifier,
      builder: (context, files, child) {
        return GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(
            files.length,
            (index) => Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return FullScreenImagesCarousel(
                          currentIndex: index,
                          images: files,
                        );
                      }),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      files[index].file!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        var newfiles = files;
                        newfiles.removeAt(index);
                        imagesNotifier.value = List.of(newfiles);
                      },
                      child: SvgPicture.asset(
                        "lib/assets/icons/button_delete.svg",
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )..add(ImageSelectButton(imagesFiles: imagesNotifier)),
        );
      },
    );
  }
}
