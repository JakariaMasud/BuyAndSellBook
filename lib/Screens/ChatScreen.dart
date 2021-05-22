import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  static final routeName="/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats"),),
      body: FutureBuilder<String>(
        future: DatabaseService.instance.getUserId(),
        builder:(context,idSnap){
          if(idSnap.connectionState==ConnectionState.done){
            return StreamBuilder<QuerySnapshot>(
                builder: (context,chatsSnap){
                  if(chatsSnap.hasData){

                  }else{
                    return Container();
                  }
                });
          }else{
            return Container();
          }
        }
      ),
    );
  }
}

