import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String message;
  String sender;
  int time;

  ChatMessage({this.message, this.sender, this.time});
  factory ChatMessage.fromDocument(DocumentSnapshot documentSnapshot){
    return ChatMessage(
      message: documentSnapshot['message'],
      sender: documentSnapshot['sender'],
      time: documentSnapshot['time']
    );

  }
  Map<String,dynamic> toMap(){
    return {
      "message":message,
      'sender':sender,
      'time':time
    };

  }
}