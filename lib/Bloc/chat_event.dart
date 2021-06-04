part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}
class LoadChatMessage extends ChatEvent {
  final String anotherUser;
  LoadChatMessage(this.anotherUser);
  @override

  List<Object> get props => [anotherUser];
}
class LoadChatList extends ChatEvent{
  @override
  List<Object> get props => [];

}
class ChatMessageUpdated extends ChatEvent{
  final List<ChatMessage> chatMessages;
  final User chatUser;
  ChatMessageUpdated(this.chatMessages,this.chatUser);
  @override
  List<Object> get props => [chatMessages,chatUser];
}
class ChatListUpdated extends ChatEvent{
  final List<User>chatList;
  final List<ChatMessage>lastMessageList;
  ChatListUpdated(this.chatList,this.lastMessageList);
  @override
  // TODO: implement props
  List<Object> get props => [chatList,lastMessageList];

}