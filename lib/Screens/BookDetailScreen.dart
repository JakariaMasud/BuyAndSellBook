
import 'dart:ui';
import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/MessageScreenArguments.dart';
import 'package:buy_book_app/Screens/MessageScreen.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class BookDetailScreen extends StatefulWidget {
  static final  routeName="/detailBook";
  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final String  bookId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
        actions: [PopUpMenu()],
      ),
      body: FutureBuilder<String>(
        future: DatabaseService.instance.getUserId(),
        builder: (context,idSnap){
          if(idSnap.connectionState!=ConnectionState.done){
            return SpinKitThreeBounce(
              color: Colors.blue,
              size: 50.0,
            );
          }else{
            return  StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService.instance.getBookStream(bookId),
              builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(!snapshot.hasData){
                  return SpinKitThreeBounce(
                    color: Colors.blue,
                    size: 50.0,
                  );
                }else{

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 200,
                            width: 200,
                            margin: EdgeInsets.all(10.0),
                            child: Image.network(snapshot.data['coverLink']),
                          ),
                        ),
                        CustomText(text: 'Title : ${snapshot.data['title']}',),
                        CustomText(text: 'Author : ${snapshot.data['author']}',),
                        CustomText(text: 'Publisher : ${snapshot.data['publisher']}',),
                        CustomText(text: 'Genre : ${snapshot.data['genre']}',),
                        CustomText(text: 'Edition : ${snapshot.data['edition']}',),
                        CustomText(text: 'Language : ${snapshot.data['language']}',),
                        CustomText(text: 'Price : ${snapshot.data['price']} Taka ',),
                        idSnap.data==snapshot.data['ownerId'] ? SizedBox(height: 30.0,):  Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, MessageScreen.routeName,arguments: MessageScreenArguments(senderId: idSnap.data, receiverId: snapshot.data['ownerId']));
                              },
                              child: Text('Chat With Book owner')),
                        )

                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
      );

  }
}
