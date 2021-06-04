import 'dart:io';
import 'package:buy_book_app/Bloc/book_bloc.dart';
import 'package:buy_book_app/Components/CustomTextField.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:buy_book_app/Services/ImagePickerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'HomeScreen.dart';

class EditBookScreen extends StatefulWidget {
  static final routeName = "/Edit";
  Book book;

  EditBookScreen({this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  TextEditingController titleController,
      authorController,
      publisherController,
      genreController,
      numberOfPageController,
      languageController,
      editionController,
      priceController;
  File pickedFile;
  bool isCoverChanged = false;

  @override
  void initState() {
    super.initState();
    initController(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Book"),
        actions: [PopUpMenu()],
      ),
      body: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state is UpdateBookSuccess) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else if (state is UpdateBookFailed) {
            print("update failed");
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
                    labelText: "Edition",
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
                                .pickImage(source: ImageSource.gallery);
                            isCoverChanged = true;
                          },
                          child: Center(
                              child: Text(
                            "Change Cover Photo ",
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
                            price == 0) {
                        } else {
                          Book updatedBook = Book(
                              id: widget.book.id,
                              title: title,
                              author: author,
                              genre: genre,
                              publisher: publisher,
                              numberOfPage: numberOfPage,
                              language: language,
                              edition: edition,
                              price: price,
                              coverLink: widget.book.coverLink);
                          BlocProvider.of<BookBloc>(context).add(UpdateBook(
                              updatedBook, pickedFile, isCoverChanged));
                          print("Updated succesfully");
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        }
                      },
                      child: Text("Update Book")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initController(Book book) {
    titleController = TextEditingController(text: book.title);
    authorController = TextEditingController(text: book.author);
    publisherController = TextEditingController(text: book.publisher);
    genreController = TextEditingController(text: book.genre);
    numberOfPageController =
        TextEditingController(text: book.numberOfPage.toString());
    languageController = TextEditingController(text: book.language);
    editionController = TextEditingController(text: book.edition);
    priceController = TextEditingController(text: book.price.toString());
  }
}
