import 'package:flutter/material.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/shared/widgets/full_screen_images_carousel.dart';

class ImagesGridView extends StatelessWidget {
  ImagesGridView({Key? key, required this.images}) : super(key: key);

  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return images == null
        ? const SizedBox.shrink()
        : GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: List.generate(
              images!.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagesCarousel(
                          currentIndex: index,
                          images: List<MultiImage>.of(
                            images!.map((e) => MultiImage(path: e)),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    images![index],
                  ),
                );
              },
            ),
          );
  }
}
