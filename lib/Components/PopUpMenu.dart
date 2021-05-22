import 'package:buy_book_app/Screens/LoginScreen.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  List<String> menuItem=<String>['Logout'];
  BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    ctx=context;
    return PopupMenuButton<String>(onSelected:handleClick,itemBuilder: (context,){
      return menuItem.map((item) {
        return PopupMenuItem<String>(
            value: item,
        child: Text(item),);
      }).toList();
    });
  }
  void handleClick(String value) async{
    switch (value) {
      case 'Logout':
       await  DatabaseService.instance.signOut();
       Navigator.pushReplacementNamed(ctx, LoginScreen.routeName);
        break;
    }
  }
}
