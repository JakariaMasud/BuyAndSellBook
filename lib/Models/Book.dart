import 'package:cloud_firestore/cloud_firestore.dart';

class Book{
  String id, title, author, publisher, genre, edition, language,  ownerId, coverLink;
  int  numberOfPage,price;
  Book({this.id,this.title,this.author,this.publisher,this.genre,this.edition,this.language,this.numberOfPage,this.price,this.ownerId,this.coverLink});

  factory Book.fromDocument(DocumentSnapshot doc){
    return Book(
        id:doc['id'],
        author:doc['author'],
        title:doc['title'],
        publisher:doc['publisher'],
        genre: doc['genre'],
        edition: doc['edition'],
      language:doc['language'],
      numberOfPage: doc['numberOfPage'],
      price: doc['price'],
      ownerId: doc['ownerId'],
      coverLink: doc['coverLink']
    );
  }
}