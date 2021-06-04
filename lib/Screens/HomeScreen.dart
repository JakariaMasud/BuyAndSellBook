
import 'package:buy_book_app/Bloc/book_bloc.dart';
import 'package:buy_book_app/Components/CustomBookList.dart';
import 'package:buy_book_app/Components/HomeDrawer.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  static final  routeName="/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookBloc>(context).add(LoadAllBooks());
    print("loadAllBooks is called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          PopUpMenu()
        ],
      ),
      body: BlocBuilder<BookBloc,BookState>(builder: (context,state){
          if(state is AllBooksLoaded){
            return CustomBookList(bookList: state.allBooks);
          }else{
            return Container();
          }


      }),
      drawer: HomeDrawer(),

    );
  }
}


