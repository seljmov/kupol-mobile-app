import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetPicker {
  static Future<void> pick({
    required BuildContext context,
    required void Function(String?) onTapItem,
    required List<String> items,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Center(
              child: SvgPicture.asset(
                "lib/assets/icons/drop_down.svg",
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Выберите событие",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ...List.generate(
              items.length,
              (index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () async {
                    onTapItem(items[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
