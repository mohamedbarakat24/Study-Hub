import 'dart:io';

import 'package:image_picker/image_picker.dart';

class NativeServices {
  final _imagePicked = ImagePicker();

  Future<File?> pickImage() async {
    final image = await _imagePicked.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
  Future<File?> pickImageFromGallery() async {
    final image = await _imagePicked.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
