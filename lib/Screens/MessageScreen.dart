import 'package:buy_book_app/Components/ChatInputField.dart';
import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Components/ReceiverMessage.dart';
import 'package:buy_book_app/Components/SenderMessage.dart';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:buy_book_app/Models/MessageScreenArguments.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  static final String routeName = "/message";

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)
        .settings
        .arguments as MessageScreenArguments;
    return Scaffold(
        appBar: AppBar(title:buildAppBar(args.receiverId),),
    body: StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService.instance.getProfileStream(args.senderId),
      builder: (context, profileSnapshot) {
        if(profileSnapshot.hasData){
          AppUser appUser=AppUser.fromDocument(profileSnapshot.data);
          return  StreamBuilder<QuerySnapshot>(
              stream: DatabaseService.instance.messageStream(args.senderId, args.receiverId),
              builder: (context, messageSnapshot) {
                if(messageSnapshot.hasData){
                  return Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                          children:
                          messageSnapshot.data.docs.map((doc) {
                            ChatMessage chatMessage= ChatMessage.fromDocument(doc);
                            return chatMessage.sender==args.senderId? SenderMessage(chatMessage):appUser.profilePic==null?ReceiverMessage(chatMessage: chatMessage):ReceiverMessage(chatMessage: chatMessage,image: appUser.profilePic);
                          }).toList()
                      ),
                      Spacer(),
                      ChatInputField(sender: args.senderId,receiver: args.receiverId,)
                    ],

                  );
                }else{

                  return Container();

                }

              }
          );
        }else{
          return Container();
        }


      }
    )
    );
  }

  Widget buildAppBar(String receiverId) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService.instance.getProfileStream(receiverId),
        builder: (context,snapshot){
        if(snapshot.hasData){
          final AppUser user=AppUser.fromDocument(snapshot.data);
          return Container(
            height: Scaffold.of(context).appBarMaxHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                user.profilePic==null? CircularImage(height: 40,width: 40): CircularImage(image: user.profilePic,height: 40,width: 40,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: user.name,textSize: 14.0,textColor: Colors.white,padding: 3.0,),
                    CustomText(text: '3 minutes Ago',textSize: 10.0,textColor: Colors.white,padding: 3.0,)
                  ],
                ),

              ],
            ),
          );
        }else{

          return Container();
        }
        });
  }
}
