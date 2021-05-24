import 'dart:async';
import 'dart:io';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
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
      String passcode=documentSnapshot.get('password');
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
      'coverLink':coverLink,
      'numberOfPage':book.numberOfPage
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
      'coverLink':coverLink,
      'numberOfPage':book.numberOfPage
    });
    print("successful ");
    

  }
  Future<void>updateProfilePic(File pickedFile) async {
    String userId=await getUserId();
    final imageUrl=await StorageService.instance.uploadProfilePic(pickedFile, '$userId .jpg');
    DocumentReference userReference = firestore.collection('users').doc(userId);
    await userReference.update({
      "profilePic":imageUrl
    });
    print('profilePic Updated');


  }

  Future<String>getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '0';
    return userId;
  }
  Future<void>sendMsg(String sender,String receiver,ChatMessage message)async {
    DocumentReference senderRef= firestore.collection('users').doc(sender).collection('chatList').doc(receiver);
    await senderRef.set({"data":123});
    DocumentReference receiverRef=firestore.collection('users').doc(receiver).collection('chatList').doc(sender);
    await receiverRef.set({"data":456});
    await senderRef.collection('messages').add(message.toMap());
    await receiverRef.collection('messages').add(message.toMap());
  }

  Stream<QuerySnapshot>booksStream(){
    return  firestore.collection('books').snapshots();
  }
  Stream<DocumentSnapshot>getBookStream(String bookId){
    return firestore.collection('books').doc(bookId).snapshots();
  }
  Stream <DocumentSnapshot>getProfileStream(String id){
    return firestore.collection('users').doc(id).snapshots();
  }
  Stream<QuerySnapshot>deskStream(String id){
    return firestore.collection('users').doc(id).collection('books').snapshots();
  }
  Stream<QuerySnapshot>messageStream(String sender,String receiver){
    return firestore.collection('users').doc(sender).collection('chatList').doc(receiver).collection('messages').orderBy('time').limit(10).snapshots();
  }
  Stream<QuerySnapshot>lastMessageStream(String sender,String receiver){
    return firestore.collection('users').doc(sender).collection('chatList').doc(receiver).collection('messages').orderBy('time').limit(1).snapshots();
  }
  Stream<QuerySnapshot>chatListStream(String userId){
    return firestore.collection('users').doc(userId).collection('chatList').snapshots();
  }






}