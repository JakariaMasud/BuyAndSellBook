import 'dart:io';

import 'package:buy_book_app/Models/Book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'StorageService.dart';

class BookDatabaseService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void>addBook(Book book,File file,String userId)async{

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

  Future<void>updateBook(Book book,File file,bool isCoverChanged,String userId)async{

    if(isCoverChanged){
      final coverLink=await StorageService.instance.uploadCover(file, '${book.id} .jpg');
      book.coverLink=coverLink;
    }
    CollectionReference userBookReference = firestore.collection('users').doc(userId).collection('books');
    userBookReference.doc(book.id).update({
      'id':book.id,
      'author':book.author,
      'title':book.title,
      'publisher':book.publisher,
      'genre':book.genre,
      'edition':book.edition,
      'language':book.language,
      'price':book.price,
      'ownerId':userId,
      'coverLink':book.coverLink,
      'numberOfPage':book.numberOfPage
    });
    CollectionReference booksReference = firestore.collection('books');
    booksReference.doc(book.id).update({
      'id':book.id,
      'author':book.author,
      'title':book.title,
      'publisher':book.publisher,
      'genre':book.genre,
      'edition':book.edition,
      'language':book.language,
      'price':book.price,
      'ownerId':userId,
      'coverLink':book.coverLink,
      'numberOfPage':book.numberOfPage
    });
    print("successful ");


  }
  Future<void>updateProfilePic(File pickedFile,String userId) async {
    final imageUrl=await StorageService.instance.uploadProfilePic(pickedFile, '$userId .jpg');
    DocumentReference userReference = firestore.collection('users').doc(userId);
    await userReference.update({
      "profilePic":imageUrl
    });
    print('profilePic Updated');


  }
  Stream<QuerySnapshot>allBooksStream(){
    return  firestore.collection('books').snapshots();
  }
  Stream<QuerySnapshot>deskBooksStream(String id){
    return firestore.collection('users').doc(id).collection('books').snapshots();
  }


}