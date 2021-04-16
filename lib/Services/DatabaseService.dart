import 'dart:async';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Models/Status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{


  FirebaseFirestore firestore = FirebaseFirestore.instance;



  Future<Status> signUp(AppUser user) async{
    DocumentSnapshot documentSnapshot=await firestore.collection("users").doc(user.id).get();
    if(documentSnapshot.exists){
      //already there is an user who use this phone number
      print("a user already exist");
      return Status.Failure;
    }else{
      print("user not exist now add the user");
      var isSuccessful=await addUser(user);
      if(isSuccessful){
        //successfully Logged In
        print("sucessfully registered");
        return Status.Success;

      }
    }
  }

  Future<Status>logIn(String id,String password) async{
    DocumentSnapshot documentSnapshot=await firestore.collection("users").doc(id).get();
    if(documentSnapshot.exists){
      //User Exist now check the password
      print("document is exist");
      String passcode=documentSnapshot.data()['password'];
      print(passcode);
      print(password);
      if(password==passcode){
        print("password is matched");
        return Status.Success;
      }else{
        print("password  is not matched");
        return Status.Failure;
      }

    }else{
      print("document is not exist");
      return Status.Failure;
    }

  }

  Future<Status> signOut(){

  }
  Future<bool>addUser(AppUser user) async{
    print("add user is in progress");
    DocumentReference usersReference = firestore.collection('users').doc(user.id);
    try{
      await usersReference.set(user.toMap());
    }catch(e){
      return false;
    }
    return true;
  }




}