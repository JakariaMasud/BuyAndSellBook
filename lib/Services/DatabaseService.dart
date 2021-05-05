import 'dart:async';
import 'dart:io';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Models/Status.dart';
import 'package:buy_book_app/Services/StorageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService{
  // make this a singleton class
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();
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
        setUserId(user.phone);
        print("sucessfully user_id stored");
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
        setUserId(id);
        print("sucessfully user_id stored");
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

  Future<Status> signOut()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    var isSuccessful=await prefs.remove("user_id");
    if(isSuccessful){
      return Status.Success;
    }
    return Status.Failure;
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

  Future<bool>setUserId(String userId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await prefs.setString("user_id",userId);
    return result;
  }

  Future<void>addBook(Book book,File file)async{

    final userId=await getUserId();
    CollectionReference userBookReference = firestore.collection('users').doc(userId).collection('books');
    final bookId=userBookReference.doc().id;
    final coverLink=await StorageService.instance.uploadCover(file, '$bookId .jpg');
    print(coverLink);
    userBookReference.doc(bookId).set({
      'id':bookId,
      'author':book.author,
      'title':book.title,
      'publisher':book.publisher,
      'genre':book.genre,
      'edition':book.edition,
      'language':book.language,
      'price':book.price,
      'ownerId':userId,
      'coverLink':coverLink
    });
    CollectionReference booksReference = firestore.collection('books');
    booksReference.doc(bookId).set({
      'id':bookId,
      'author':book.author,
      'title':book.title,
      'publisher':book.publisher,
      'genre':book.genre,
      'edition':book.edition,
      'language':book.language,
      'price':book.price,
      'ownerId':userId,
      'coverLink':coverLink
    });
    print("successful ");
    

  }

  Future<String>getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '0';
    return userId;
  }

  Stream<QuerySnapshot>booksStream(){
    return  FirebaseFirestore.instance.collection('books').snapshots();
  }





}