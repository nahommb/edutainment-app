import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyImagePicker{

  final ImagePicker _picker = ImagePicker();
  File? _image;

  // File? get image =>_image;

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(_image);
      return _image;
    }
  }

  // Future<void> pickImageFromCamera() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //   }
  // }
}


