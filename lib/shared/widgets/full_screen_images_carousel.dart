import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FullScreenImagesCarousel extends StatelessWidget {
  FullScreenImagesCarousel({
    Key? key,
    required this.images,
    this.currentIndex,
  }) : super(key: key);

  final List<MultiImage> images;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.75;
    final _imageActiveNotifier = ValueNotifier<int>(currentIndex ?? 0);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Visibility(
        visible: images.length == 0,
        child: Center(
          child: Text(
            "Список изображений пуст...",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        replacement: ValueListenableBuilder<int>(
          valueListenable: _imageActiveNotifier,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    return InteractiveViewer(
                      child: images[index].path == null
                          ? Image.file(images[index].file!)
                          : Image.asset(images[index].path!),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: images.length > 1,
                    autoPlay: false,
                    disableCenter: true,
                    viewportFraction: 1,
                    height: height,
                    initialPage: value,
                    onPageChanged: (index, _) {
                      _imageActiveNotifier.value = index;
                    },
                  ),
                ),
                Visibility(
                  visible: images.length > 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: AnimatedSmoothIndicator(
                      activeIndex: value,
                      count: images.length,
                      effect: WormEffect(
                        dotWidth: 8,
                        dotHeight: 8,
                        activeDotColor: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
