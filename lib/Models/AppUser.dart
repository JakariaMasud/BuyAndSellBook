import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String name,phone,email,password,profilePic,designation,id;

  AppUser({this.id, this.name, this.phone, this.email, this.password,
    this.profilePic, this.designation});

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "name":name,
      "phone":phone,
      "email":email,
      "profilePic":profilePic,
      "designation":designation,
      "password":password

    };
  }
  factory AppUser.fromDocument(DocumentSnapshot doc){
    return AppUser(
      id: doc['id'],
      name: doc['name'],
      phone: doc['phone'],
      email: doc['email'],
      profilePic: doc['profilePic'],
      designation: doc['designation'],
      password: doc['password']

    );
  }
}