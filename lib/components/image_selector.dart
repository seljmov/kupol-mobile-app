import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kupol_app/theme.dart';

class ImageSeletor {
  Future<File?> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      var pickedFile = await _picker.pickImage(source: source);
      return File(pickedFile!.path);
    } catch (e) {
      print("ImageSeletor -> pickImage() -> e -> $e");
    }

    return null;
  }

  Future<File?> select(BuildContext context) async {
    File? file;
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) => Column(
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
              "Откуда взять изображение?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: secondaryColor,
            ),
            title: Text("С камеры"),
            onTap: () async {
              file = await _pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.photo_library,
              color: secondaryColor,
            ),
            title: Text("Из галереи"),
            onTap: () async {
              file = await _pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 24)
        ],
      ),
    );
    return file;
  }
}
