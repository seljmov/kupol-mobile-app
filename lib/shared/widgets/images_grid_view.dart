import 'package:flutter/material.dart';
import 'package:kupol_app/components/full_screen_view.dart';

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
                        builder: (context) => FullScreenView(
                          child: Image.asset(
                            images![index],
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
