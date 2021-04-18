
import 'package:buy_book_app/Components/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  static final  routeName="/addBook";
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController=TextEditingController();
  final authorController=TextEditingController();
  final publisherController=TextEditingController();
  final genreController=TextEditingController();
  final numberOfPageController=TextEditingController();
  final languageController=TextEditingController();
  final editionController=TextEditingController();
  final priceController=TextEditingController();
  final isbnController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Add a Book"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CustomTextField(size: size, controller: titleController, hintText: "Enter The Title ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: authorController, hintText: "Enter The Author Name ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: publisherController, hintText: "Enter The Publisher Name  ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: genreController, hintText: "Enter The Genre ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: numberOfPageController, hintText: "Enter The Number Of Page ", textInputType: TextInputType.number),
              CustomTextField(size: size, controller: languageController, hintText: "Enter The Language Of the Book ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: editionController, hintText: "Enter The Edition Of the Book ", textInputType: TextInputType.text),
              CustomTextField(size: size, controller: priceController, hintText: "Enter The Desired price ", textInputType: TextInputType.number),
              Row(
                children: [
              Container(
              width: size.width*0.4,
                height: size.height*0.065,
                margin: EdgeInsets.only(left: 20.0,top: 15.0,bottom: 15.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(29.0),
                ),
                child: Center(child: Text("Select Cover Photo ",style: TextStyle(color: Colors.white),)),
              ),
                  Spacer(),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
