
import 'package:buy_book_app/Bloc/chat_bloc.dart';
import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static final routeName="/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(LoadChatList());
    print(" load chatlist is called");
    return Scaffold(
      appBar: AppBar(title: Text("Inbox"),),
      body: BlocBuilder<ChatBloc,ChatState>(
          builder: (context,state){
            if(state is ChatListLoaded){
              print(state.lastMessageList.first.message);
              return ListView.builder(
                itemCount: state.chatUserList.length,
                  itemBuilder: (context,index) {
                    User singleUser =state.chatUserList[index];
                    ChatMessage lastMsg=state.lastMessageList[index];
                    return ListTile(
                        leading: singleUser.profilePic==null ? CircularImage():CircularImage(image: singleUser.profilePic,),
                        title: Text(singleUser.name),
                      subtitle: Text(lastMsg.message),
                    );
                  }
              );
            }else{
              return Container();
            }
          })
    );
  }
}


