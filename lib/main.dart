
import 'package:buy_book_app/Screens/AddBookScreen.dart';
import 'package:buy_book_app/Screens/BookDetailScreen.dart';
import 'package:buy_book_app/Screens/ChatScreen.dart';
import 'package:buy_book_app/Screens/DeskScreen.dart';
import 'package:buy_book_app/Screens/HomeScreen.dart';
import 'package:buy_book_app/Screens/MessageScreen.dart';
import 'package:buy_book_app/Screens/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SignUpScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        SignUpScreen.routeName: (context)=>SignUpScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        AddBookScreen.routeName:(context)=>AddBookScreen(),
        BookDetailScreen.routeName:(context)=>BookDetailScreen(),
        ProfileScreen.routeName: (context)=>ProfileScreen(),
        DeskScreen.routeName:(context)=>DeskScreen(),
        MessageScreen.routeName: (context)=>MessageScreen(),
        ChatScreen.routeName:(context)=>ChatScreen()

      },
    );
  }
}





