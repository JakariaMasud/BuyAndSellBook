import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:flutter/material.dart';
class SenderMessage extends StatelessWidget {
  ChatMessage chatMessage;

  SenderMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 5.0,right: 2.0),
        decoration: BoxDecoration(
          color: Colors.blue,
            borderRadius: BorderRadius.circular(30.0)),
        child: CustomText(text: chatMessage.message,textColor: Colors.white,)
      ),
    );
  }
}
