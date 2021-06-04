
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Screens/BookDetailScreen.dart';
import 'package:flutter/material.dart';

class CustomBookList extends StatelessWidget {
  final List<Book>bookList;
  const CustomBookList({
    Key key,
    @required this.bookList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: bookList.map((book) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, BookDetailScreen.routeName,arguments: book.id);
            },
            child: Card(
              elevation: 5.0,
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.network(book.coverLink),
                  ),
                  Column(
                    children: [
                      Text(book.title),
                      Text('Author : ${book.author} '),
                      Text('Publisher : ${book.publisher}'),
                      Text('Price : ${book.price} Taka')
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

}