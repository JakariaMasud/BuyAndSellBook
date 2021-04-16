
import 'package:buy_book_app/Models/Status.dart';
import 'package:buy_book_app/Screens/HomeScreen.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SignUpScreen.dart';
class LoginScreen extends StatefulWidget {
  static final  routeName="/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseService databaseService=DatabaseService();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width*0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Enter phone",
                    border: InputBorder.none,
                    icon: Icon(Icons.person,color: Colors.blue)
                ),
              ),
            ),
            Container(
              width: size.width*0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0,),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(29.0),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Password",
                    icon: Icon(Icons.lock,color: Colors.blue)
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{
                String email=emailController.text.toString();
                String password=passwordController.text.toString();
                print("email : $email password: $password");
                print("login is processing");
                var status=await databaseService.logIn(email, password);
                print("successfully returned ${status.toString()}");
                if(status==Status.Success){
                  print("successful");
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  Fluttertoast.showToast(msg: "Logging in Successfully");
                }else{
                  Fluttertoast.showToast(msg: "Phone or password is wrong");
                  print("failed");
                }

               // Navigator.pushReplacementNamed(context, Wrapper.routeName);


              },
              child: Container(
                width: size.width*0.8,
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
            GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context,  SignUpScreen.routeName);

              },
              child: Container(
                width: size.width*0.8,
                height: size.height*0.065,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(29.0),
                ),
                child: Center(child: Text("Create An Account",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}