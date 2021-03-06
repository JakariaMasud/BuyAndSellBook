import 'dart:io';
import 'package:buy_book_app/Bloc/book_bloc.dart';
import 'package:buy_book_app/Components/CustomTextField.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Screens/HomeScreen.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:buy_book_app/Services/ImagePickerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddBookScreen extends StatefulWidget {
  static final routeName = "/addBook";

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final publisherController = TextEditingController();
  final genreController = TextEditingController();
  final numberOfPageController = TextEditingController();
  final languageController = TextEditingController();
  final editionController = TextEditingController();
  final priceController = TextEditingController();
  final isbnController = TextEditingController();
  File pickedFile;

  @override
  Widget build(BuildContext context) {
    final String bookId = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Book"),
        actions: [PopUpMenu()],
      ),
      body: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if(state is AddBookSuccess){
            print("successful add");
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }else if(state is AddBookFailed ){
            print("failed to add");
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomTextField(
                    size: size,
                    controller: titleController,
                    labelText: "Title ",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: authorController,
                    labelText: "Author Name ",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: publisherController,
                    labelText: "Publisher Name  ",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: genreController,
                    labelText: "Genre ",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: numberOfPageController,
                    labelText: "Number Of Page ",
                    textInputType: TextInputType.number),
                CustomTextField(
                    size: size,
                    controller: languageController,
                    labelText: "Language",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: editionController,
                    labelText: " Edition",
                    textInputType: TextInputType.text),
                CustomTextField(
                    size: size,
                    controller: priceController,
                    labelText: "Desired price ",
                    textInputType: TextInputType.number),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height * 0.065,
                      margin:
                          EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(29.0),
                      ),
                      child: GestureDetector(
                          onTap: () async {
                            pickedFile = await ImagePickerService.instance
                                .pickImage(source: ImageSource.gallery) as File;
                          },
                          child: Center(
                              child: Text(
                            "Select Cover Photo ",
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                    Spacer(),
                  ],
                ),
                Container(
                  width: size.width * 0.9,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        String title = titleController.text.toString();
                        String author = authorController.text.toString();
                        String genre = genreController.text.toString();
                        String publisher = publisherController.text.toString();
                        int numberOfPage =
                            int.parse(numberOfPageController.text.toString());
                        String language = languageController.text.toString();
                        String edition = editionController.text.toString();
                        int price = int.parse(priceController.text.toString());
                        if (title.isEmpty ||
                            author.isEmpty ||
                            genre.isEmpty ||
                            publisher.isEmpty ||
                            numberOfPage == 0 ||
                            language.isEmpty ||
                            edition.isEmpty ||
                            price == 0 ||
                            pickedFile == null) {
                          print("Field is not valid");
                        } else {
                          Book book = Book(
                              title: title,
                              author: author,
                              genre: genre,
                              publisher: publisher,
                              numberOfPage: numberOfPage,
                              language: language,
                              edition: edition,
                              price: price);
                          print("file is being uploaded");
                          await DatabaseService.instance
                              .addBook(book, pickedFile);
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        }
                      },
                      child: Text("Add Book")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
