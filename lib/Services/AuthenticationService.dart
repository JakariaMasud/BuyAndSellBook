
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Models/Status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService{

  FirebaseFirestore database = FirebaseFirestore.instance;
  Future<bool> register(User user) async{
    DocumentSnapshot documentSnapshot=await database.collection("users").doc(user.id).get();
    if(documentSnapshot.exists){
      print("user already exist");
      return false;
    }else{
      print("user not exist now add the user");
      var isSuccessful=await addUser(user);
      if(isSuccessful){
        return true;

      }
    }
  }

  Future<bool>setUserId(String userId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await prefs.setString("user_id",userId);
    return result;
  }
  Future<User>logIn(String id,String password) async{
    DocumentSnapshot documentSnapshot=await database.collection("users").doc(id).get();
    if(documentSnapshot.exists){
      String passcode=documentSnapshot.get('password');
      if(password==passcode){
        await setUserId(id);
        return User.fromDocument(documentSnapshot);
      }else{
        return null;
      }

    }else{
      print("document is not exist");
      return null;
    }

  }

  Future<bool> signOut()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isSuccessful=await prefs.remove("user_id");
    return isSuccessful;
  }
  Future<bool>addUser(User user) async{
    print("add user is in progress");
    DocumentReference usersReference = database.collection('users').doc(user.id);
    try{
      await usersReference.set(user.toMap());
    }catch(e){
      return false;
    }
    return true;
  }
  Future<String>getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '0';
    return userId;
  }

  Future<User>getUserById(String token)async{
    final userSnapShot=await database.collection('users').doc(token).get();
    User user=User.fromDocument(userSnapShot);
    return user ;
  }
}