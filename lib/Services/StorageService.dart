import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class StorageService{
  StorageService._privateConstructor();
  static final StorageService instance = StorageService._privateConstructor();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future <String> uploadCover(File file,String fileName) async{
    String downloadUrl;
   final uploadTask=  storage.ref('images/$fileName').putFile(file);
   await uploadTask.whenComplete(() async=> downloadUrl=await uploadTask.snapshot.ref.getDownloadURL());
   return downloadUrl;
  }
  Future <String> uploadProfilePic(File file,String fileName) async{
    String downloadUrl;
    final uploadTask=  storage.ref('profilePic/$fileName').putFile(file);
    await uploadTask.whenComplete(() async=> downloadUrl=await uploadTask.snapshot.ref.getDownloadURL());
    return downloadUrl;
  }
}