
import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Screens/AddBookScreen.dart';
import 'package:buy_book_app/Screens/ChatScreen.dart';
import 'package:buy_book_app/Screens/DeskScreen.dart';
import 'package:buy_book_app/Screens/LoginScreen.dart';
import 'package:buy_book_app/Screens/ProfileScreen.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Theme.of(context).primaryColor,
            child: Center(
              child:BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
                if(state is Authenticated){
                  return Column(
                      children: [
                      state.user.profilePic==null ? CircularImage():CircularImage(image: state.user.profilePic,),
                CustomText(text: state.user.name,textColor: Colors.white,textSize: 22.0,)
                ]);
                }else{
                 return Container();
                }
              })
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile",style: TextStyle(fontSize: 17.0),),
            onTap: (){
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Inbox",style: TextStyle(fontSize: 17.0),),
            onTap:  (){
              Navigator.pushNamed(context, ChatScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Book",style: TextStyle(fontSize: 17.0),),
            onTap: (){
              Navigator.pushNamed(context, AddBookScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("My Desk",style: TextStyle(fontSize: 17.0),),
            onTap: (){
              Navigator.pushNamed(context, DeskScreen.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Sign Out",style: TextStyle(fontSize: 17.0),),
            onTap: () async{
              await  DatabaseService.instance.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }


}
