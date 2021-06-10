import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  static final  routeName="/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  BlocListener(
        child: Scaffold(
          appBar: AppBar(title: Text("Login"),),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(size: size, controller: phoneController,icon: Icon(Icons.phone,color: Colors.blue,),textInputType: TextInputType.phone,labelText: "Enter Phone Number",),
                  CustomTextField(size: size, controller: passwordController,icon: Icon(Icons.lock,color: Colors.blue,),textInputType: TextInputType.text,labelText: "Enter Password",obscureText: true,),
                  GestureDetector(
                    onTap: ()async{
                      String userId=phoneController.text.toString();
                      String password=passwordController.text.toString();
                      BlocProvider.of<AuthBloc>(context).add(Login(userId: userId,password: password));
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
              ),
            ),
          ),
        ),
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context,state){
          if(state is Authenticated){
            Navigator.pushNamed(context, HomeScreen.routeName);
          }else if(state is Authenticating){
            print("Authenticating ...");
          }
        });
  }
}
