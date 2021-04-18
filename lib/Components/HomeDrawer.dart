
import 'package:buy_book_app/Screens/AddBookScreen.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({@required this.userName,@required this.imageLink});
  String userName,imageLink;
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25.0,bottom: 10.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imageLink),fit: BoxFit.fill
                      )
                    ),
                  ),
                  Text(userName,style: TextStyle(fontSize: 22.0,color: Colors.white),)
                ],

              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile",style: TextStyle(fontSize: 17.0),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Inbox",style: TextStyle(fontSize: 17.0),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Book",style: TextStyle(fontSize: 17.0),),
            onTap: (){
              Navigator.pushNamed(context, AddBookScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Edit Desk",style: TextStyle(fontSize: 17.0),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("My Desk",style: TextStyle(fontSize: 17.0),),
            onTap: null,
          ),

          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text("Sign Out",style: TextStyle(fontSize: 17.0),),
            onTap: null,
          ),
        ],
      ),
    );
  }


}
