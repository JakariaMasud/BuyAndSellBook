import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
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
      appBar: AppBar(title: Text("Inbox"),),
      body: FutureBuilder<String>(
          future: DatabaseService.instance.getUserId(),
          builder:(context,idSnap){
            if(idSnap.connectionState==ConnectionState.done){
              return StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService.instance.chatListStream(idSnap.data),
                  builder: (context,chatsSnap){
                    if(chatsSnap.hasData){
                      print(chatsSnap.data.docs.toString());
                      return ListView(
                        children: chatsSnap.data.docs.map((doc) {
                          return StreamBuilder<DocumentSnapshot>(
                              stream: DatabaseService.instance.getProfileStream(doc.id),
                              builder: (context,profileSnap){
                                if(profileSnap.hasData){
                                  AppUser appUser=AppUser.fromDocument(profileSnap.data);
                                  return StreamBuilder<QuerySnapshot>(
                                      stream: DatabaseService.instance.lastMessageStream(idSnap.data, appUser.id),
                                      builder: (context,lastMsgSnap){
                                        if(lastMsgSnap.hasData){
                                          ChatMessage message=ChatMessage.fromDocument(lastMsgSnap.data.docs[0]);
                                          return ListTile(
                                            leading: appUser.profilePic==null ? CircularImage(width: 50.0,height: 50.0,):CircularImage(image: appUser.profilePic,height: 50,width: 50,),
                                            title: Text(appUser.name),
                                            subtitle: Text(message.message),
                                          );
                                        }else{
                                          return Container();
                                        }
                                      });
                                }else{
                                  return Container();
                                }
                              });
                        }).toList(),
                      );

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

