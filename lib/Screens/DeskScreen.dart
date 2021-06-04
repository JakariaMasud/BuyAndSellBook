import 'package:buy_book_app/Bloc/book_bloc.dart';
import 'package:buy_book_app/Components/CustomBookList.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Screens/EditBookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BookDetailScreen.dart';
class DeskScreen extends StatefulWidget {
  static final routeName='/desk';
  @override
  _DeskScreenState createState() => _DeskScreenState();
}

class _DeskScreenState extends State<DeskScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookBloc>(context).add(LoadDeskBooks());
    print("loadDeskBooks is called");
    return Scaffold(
      appBar: AppBar(
        title: Text('My Desk'),
        actions: [
          PopUpMenu()
        ],
      ),
      body: BlocBuilder<BookBloc,BookState>(
        builder: (context,state){
          if(state is DeskBooksLoaded){
          return CustomBookList(bookList: state.deskBooks);
          }else{
            return Container();
          }
        },
      ),
    );
  }
  void _showPopupMenu(Book book) async {
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(350, 150, 10, 10),
        items: [
    PopupMenuItem(
    value: 1,
    child: Text("View"),
    ),
    PopupMenuItem(
    value: 2,
    child: Text("Edit"),
    ),
    PopupMenuItem(
    value: 3,
    child: Text("Delete"),
    ),
    ],
    elevation: 8.0,
    ).then((value){

// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

    if(value==1){
      Navigator.pushNamed(context, BookDetailScreen.routeName,arguments: book.id);
    }else if(value==2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBookScreen(book: book)));

    }

    });
  }
}
