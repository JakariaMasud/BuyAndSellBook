part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}
class ChatMessagesLoaded extends ChatState{
  final List<ChatMessage> messageList;
  final User chatUser;
  ChatMessagesLoaded(this.messageList,this.chatUser);
  @override
  List<Object> get props => [messageList,chatUser];
}
class ChatListLoaded extends ChatState{
  final List<ChatMessage> lastMessageList;
  final List<User>chatUserList;
  ChatListLoaded(this.chatUserList,this.lastMessageList);
  @override
  List<Object> get props => [chatUserList,lastMessageList];
}
