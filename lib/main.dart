
import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Bloc/book_bloc.dart';
import 'package:buy_book_app/Bloc/chat_bloc.dart';
import 'package:buy_book_app/Bloc/desk_book_bloc.dart';
import 'package:buy_book_app/Screens/AddBookScreen.dart';
import 'package:buy_book_app/Screens/BookDetailScreen.dart';
import 'package:buy_book_app/Screens/ChatScreen.dart';
import 'package:buy_book_app/Screens/DeskScreen.dart';
import 'package:buy_book_app/Screens/EditBookScreen.dart';
import 'package:buy_book_app/Screens/HomeScreen.dart';
import 'package:buy_book_app/Screens/MessageScreen.dart';
import 'package:buy_book_app/Screens/ProfileScreen.dart';
import 'package:buy_book_app/Services/AuthenticationService.dart';
import 'package:buy_book_app/Services/ChatDatabaseService.dart';
import 'package:buy_book_app/Services/FirestoreService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SignUpScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  BookDatabaseService bookDatabaseService = BookDatabaseService();
  AuthenticationService authenticationService=AuthenticationService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context)=>AuthBloc(authenticationService:authenticationService)..add(AppStarted())),
          BlocProvider<BookBloc>(create: (context)=>BookBloc(bookDatabaseService: bookDatabaseService,authBloc: BlocProvider.of<AuthBloc>(context))..add(LoadAllBooks())),
          BlocProvider<DeskBookBloc>(create: (context)=>DeskBookBloc(bookDatabaseService: bookDatabaseService,authBloc: BlocProvider.of<AuthBloc>(context))..add(LoadDeskBooks())),
          BlocProvider<ChatBloc>(create: (context)=>ChatBloc(chatDatabaseService: ChatDatabaseService(),authBloc:BlocProvider.of<AuthBloc>(context),authenticationService: authenticationService)),

        ],
        child: MaterialApp(
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
            ChatScreen.routeName:(context)=>ChatScreen(),
            EditBookScreen.routeName: (context)=>EditBookScreen()

          },
        ),
      );

  }
}





