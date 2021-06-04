import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Services/AuthenticationService.dart';
import 'package:buy_book_app/Services/ChatDatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  AuthBloc authBloc;
  StreamSubscription<AuthState> _authStateStreamSubscription;
  StreamSubscription _chatMessagesSubscription;
  StreamSubscription _chatListSubscription;
  ChatDatabaseService chatDatabaseService;
  AuthenticationService authenticationService;
  User user;

  ChatBloc({this.authBloc, this.chatDatabaseService,this.authenticationService}) : super(ChatInitial()) {
    _authStateStreamSubscription = authBloc.listen((authState) {
      if (authState is Authenticated) {
        user = authState.user;
      }
    });
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is LoadChatMessage) {
      List<ChatMessage> chatMessageList;
      User chatUser;
      chatUser =
          await authenticationService.getUserById(event.anotherUser);
      _chatMessagesSubscription = chatDatabaseService
          .messageStream(user.id, event.anotherUser)
          .listen((querySnapshot) {
        querySnapshot.docs.map((documentSnapshot) =>
            chatMessageList.add(ChatMessage.fromDocument(documentSnapshot)));
        add(ChatMessageUpdated(chatMessageList, chatUser));
      });
    } else if (event is ChatMessageUpdated) {
      yield ChatMessagesLoaded(event.chatMessages, event.chatUser);
    } else if (event is LoadChatList) {
      print("chat list is called from bloc");
      List<User>chatList;
      List<ChatMessage>lastMsgList;
      List<String>idList;
      _chatListSubscription =
          chatDatabaseService.chatListStream(user.id).listen((querySnapshot) {
            print("chat list is called from stream");
        querySnapshot.docs.map((documentSnapshot)  {
        idList.add(documentSnapshot.id);
        });
      });
      for(String id in idList){
        User user= await authenticationService.getUserById(id);
        QuerySnapshot snap=await chatDatabaseService.lastMessage(user.id,id);
        ChatMessage chatMessage=ChatMessage.fromDocument(snap.docs[0]);
        print("document Id : ${id}");
        print("chat msg : ${chatMessage.message}");
        print("user name : ${user.name}");
        chatList.add(user);
        lastMsgList.add(chatMessage);
      }
      add(ChatListUpdated(chatList, lastMsgList));
    }
    else if(event is ChatListUpdated){
      yield ChatListLoaded(event.chatList, event.lastMessageList);
    }
  }

  @override
  Future<void> close() {
    _chatListSubscription.cancel();
    _chatMessagesSubscription.cancel();
    _authStateStreamSubscription.cancel();
    return super.close();
  }
}
