import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kupol_app/shared/components/multi_image_model.dart';
import 'package:kupol_app/theme.dart';

class ImageSeletor {
  Future<File?> _pickImageFromCamera() async {
    try {
      final _picker = ImagePicker();
      var pickedFile = await _picker.pickImage(source: ImageSource.camera);
      return pickedFile == null ? null : File(pickedFile.path);
    } catch (e) {
      print("ImageSeletor -> _pickImageFromCamera() -> e -> $e");
    }
    return null;
  }

  Future<List<File>?> _pickImagesFromGallery() async {
    try {
      final _picker = ImagePicker();
      var pickedFileList = await _picker.pickMultiImage();
      return pickedFileList == null
          ? null
          : List.of(pickedFileList.map((e) => File(e.path)));
    } catch (e) {
      print("_pickImagesFromGallery() -> e -> $e");
    }
  }

  Future<List<MultiImage>> select(BuildContext context) async {
    List<File> myFiles = [];
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
              var file = await _pickImageFromCamera();
              if (file != null) {
                myFiles.add(file);
              }
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
              var files = await _pickImagesFromGallery();
              if (files != null) {
                myFiles = List.of(files.map((e) => File(e.path)));
              }
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 24)
        ],
      ),
    );
    var multiImages = List<MultiImage>.of(
      myFiles.map((e) => MultiImage(file: e)),
    );
    return multiImages;
  }
}
