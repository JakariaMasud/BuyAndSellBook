import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:flutter/material.dart';

import 'CustomText.dart';

class ReceiverMessage extends StatelessWidget {
  ChatMessage chatMessage;
  String image;

  ReceiverMessage({@required this.chatMessage, this.image});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 5.0,right: 2.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0)),
        child: CustomText(text: chatMessage.message),
      ),
    );
  }
}