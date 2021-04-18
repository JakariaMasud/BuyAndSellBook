import 'package:buy_book_app/Components/HomeDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final  routeName="/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: HomeDrawer(userName: "John Doe",imageLink: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),

    );
  }
}
