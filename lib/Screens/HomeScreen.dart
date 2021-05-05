import 'package:buy_book_app/Components/HomeDrawer.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService.instance.booksStream(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          );
        }else{
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                margin: EdgeInsets.all(10.0),
                child: Card(
                 elevation: 5.0,
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.network(document['coverLink']),
                      ),
                      Column(
                        children: [
                          Text(document['title']),
                          Text('Author : ${document['author']} '),
                          Text('Publisher : ${document['publisher']}'),
                          Text('Price : ${document['price']} Taka')
                        ],
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      }),
      drawer: HomeDrawer(userName: "John Doe",imageLink: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),

    );
  }
}
