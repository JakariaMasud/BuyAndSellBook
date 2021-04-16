import 'package:buy_book_app/Models/AppUser.dart';
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
  DatabaseService databaseService=DatabaseService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: size.width*0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                keyboardType: TextInputType.name,
               
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Enter name",
                    border: InputBorder.none,
                  icon: Icon(Icons.person,color: Colors.blue)
                ),
              ),
            ),
            Container(
              width: size.width*0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: InputBorder.none,
                    icon: Icon(Icons.email,color: Colors.blue)
                ),
              ),
            ),
            Container(
              width: size.width*0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    border: InputBorder.none,
                    icon: Icon(Icons.phone,color: Colors.blue)
                ),
              ),
            ),
            Container(
              width: size.width*0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: designationController,
                decoration: InputDecoration(
                    hintText: "Enter Designation",
                    border: InputBorder.none,
                    icon: Icon(Icons.work,color: Colors.blue)
                ),
              ),
            ),
            Container(
              width: size.width*0.9,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: InputBorder.none,
                    icon: Icon(Icons.lock,color: Colors.blue)
                ),
              ),
            ),
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
            AppUser user=AppUser(id:phone,name: name,phone:phone,email: email,designation: designation,password: password);
            var  status=await databaseService.signUp(user);
            print("sucessfully returned ${status.toString()}");
            switch(status) {
              case Status.Success:
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                Fluttertoast.showToast(msg: "Successfully Account Created");
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
    );
  }
}
