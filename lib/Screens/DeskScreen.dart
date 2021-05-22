import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'BookDetailScreen.dart';
class DeskScreen extends StatefulWidget {
  static final routeName='/desk';
  @override
  _DeskScreenState createState() => _DeskScreenState();
}

class _DeskScreenState extends State<DeskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Desk'),
        actions: [
          PopUpMenu()
        ],
      ),
      body: FutureBuilder<String>(
        future: DatabaseService.instance.getUserId(),
        builder: (ctx,idSnap){
          if(idSnap.connectionState!=ConnectionState.done){
            return SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            );
          }else{
            return StreamBuilder<QuerySnapshot>(
                stream: DatabaseService.instance.deskStream(idSnap.data),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    );
                  }else{
                    return ListView(
                      children: snapshot.data.docs.map((document) {
                        Book book=Book.fromDocument(document);
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, BookDetailScreen.routeName,arguments: book.id);
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    child: Image.network(book.coverLink),
                                  ),
                                  Column(
                                    children: [
                                      Text(book.title),
                                      Text('Author : ${book.author} '),
                                      Text('Publisher : ${book.publisher}'),
                                      Text('Price : ${book.price} Taka')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                });
          }
        },
      )
    );
  }
}
