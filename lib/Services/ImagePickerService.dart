import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService{
  ImagePickerService._privateConstructor();
  static final ImagePickerService instance = ImagePickerService._privateConstructor();
  final picker = ImagePicker();
  Future<File>pickImage({@required ImageSource source}) async{
    final pickedFile=await picker.getImage(source: source);
    return File(pickedFile.path);
  }

}