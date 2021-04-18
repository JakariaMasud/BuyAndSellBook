
import 'package:buy_book_app/Components/CustomTextField.dart';
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
  Future idFuture=DatabaseService.instance.getUserId();
  final phoneController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
      future: idFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.data=='0'){
               return Scaffold(
              appBar: AppBar(
                title: Text("Login"),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(size: size, controller: phoneController,icon: Icon(Icons.phone,color: Colors.blue,),textInputType: TextInputType.phone,hintText: "Enter Phone Number",),
                      CustomTextField(size: size, controller: passwordController,icon: Icon(Icons.lock,color: Colors.blue,),textInputType: TextInputType.text,hintText: "Enter Password",obscureText: true,),
                      GestureDetector(
                        onTap: ()async{
                          String email=phoneController.text.toString();
                          String password=passwordController.text.toString();
                          print("email : $email password: $password");
                          print("login is processing");
                          var status=await DatabaseService.instance.logIn(email, password);
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
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,  SignUpScreen.routeName);

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
                          child: Center(child: Text("Create An Account",style: TextStyle(color: Colors.white),)),
                        ),
                      )
                    ],
                  ) ,
                ),
              ),
            );;
          }else{
            return HomeScreen();
          }
        }
       else {
          return Scaffold (
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }

      }
    );
  }
}

