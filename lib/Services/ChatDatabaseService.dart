import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDatabaseService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>messageStream(String sender,String receiver){
    return firestore.collection('users').doc(sender).collection('chatList').doc(receiver).collection('messages').orderBy('time').limit(10).snapshots();
  }
  Future<QuerySnapshot>lastMessage(String sender,String receiver) async {
    return await firestore.collection('users').doc(sender).collection('chatList').doc(receiver).collection('messages').orderBy('time').limit(1).get();
  }
  Stream<QuerySnapshot>chatListStream(String userId){
    return firestore.collection('users').doc(userId).collection('chatList').snapshots();
  }
}