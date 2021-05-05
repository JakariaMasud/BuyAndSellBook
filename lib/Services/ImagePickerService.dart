import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService{
  final picker = ImagePicker();
  Future<File>pickImage({@required ImageSource source}) async{
    final pickedFile=await picker.getImage(source: source);
    return File(pickedFile.path);
  }

}