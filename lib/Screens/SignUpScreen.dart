import 'package:buy_book_app/Components/CustomTextField.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Models/Status.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static final  routeName="/register";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final designationController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CustomTextField(size: size, controller: nameController,icon: Icon(Icons.person,color: Colors.blue,),textInputType: TextInputType.name,labelText: "Enter Name",),
              CustomTextField(size: size, controller: emailController,icon: Icon(Icons.email,color: Colors.blue,),textInputType: TextInputType.emailAddress,labelText: "Enter Email",),
              CustomTextField(size: size, controller: phoneController,icon: Icon(Icons.phone,color: Colors.blue,),textInputType: TextInputType.phone,labelText: "Enter phone Number",),
              CustomTextField(size: size, controller: designationController,icon: Icon(Icons.work,color: Colors.blue,),textInputType: TextInputType.phone,labelText: "Enter Designation",),
              CustomTextField(size: size, controller: passwordController,icon: Icon(Icons.lock,color: Colors.blue,),textInputType: TextInputType.text,labelText: "Enter Password",obscureText: true,),
          GestureDetector(
            onTap: () async {
              if(nameController.text.isEmpty){
              Fluttertoast.showToast(msg: "Name is not valid");
                return;
              }
              if(emailController.text.isEmpty){
                Fluttertoast.showToast(msg: "Email is not valid");
                return;
              }
              if(phoneController.text.isEmpty){
                Fluttertoast.showToast(msg: "Phone Number is not valid");
                return ;
              }
              if(designationController.text.isEmpty){
                Fluttertoast.showToast(msg: "Designation is not valid");
                return ;
              }
              if(passwordController.text.isEmpty){
                Fluttertoast.showToast(msg: "Password is not valid");
                return ;
              }
              String email=emailController.text.toString();
              String password=passwordController.text.toString();
              String name=nameController.text.toString();
              String designation=designationController.text.toString();
              String phone=phoneController.text.toString();
              User user=User(id:phone,name: name,phone:phone,email: email,designation: designation,password: password,profilePic: null);
              var  status=await DatabaseService.instance.signUp(user);
              print("sucessfully returned ${status.toString()}");
              switch(status) {
                case Status.Success:
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  Fluttertoast.showToast(msg: "Successfully Account Created");
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                break;
                case Status.Failure:
                  Fluttertoast.showToast(msg: "failed to Create an account");
                break;
              }

            },
            child: Container(
              width: size.width*0.9,
              height: size.height*0.065,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(29.0),
              ),
              child: Center(child: Text("Register",style: TextStyle(color: Colors.white),)),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Container(
              width: size.width*0.9,
              height: size.height*0.065,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(29.0),
              ),
              child: Center(child: Text("Login",style: TextStyle(color: Colors.white),)),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
