import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:buy_book_app/Services/ImagePickerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
class ProfileScreen extends StatefulWidget {
  static final routeName='/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),actions: [PopUpMenu()],),
      body:BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state){
          if(state is Authenticated){
            User user=state.user;
            return Container(
              margin: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
              decoration: BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: user.profilePic==null ? CircularImage(onPressed: onImagePressed,) : CircularImage(image: user.profilePic,onPressed: onImagePressed,),),
                  CustomText(text: user.name,textColor: Colors.white,),
                  CustomText(text:"Designation : ${user.designation}",textColor: Colors.white),
                  CustomText(text:"Email  : ${user.email}",textColor: Colors.white),
                  CustomText(text:"Phone : ${user.phone}",textColor: Colors.white)
                ],
              ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
  void onImagePressed() async {
    final pickedImage=await ImagePickerService.instance.pickImage(source: ImageSource.gallery);
    await DatabaseService.instance.updateProfilePic(pickedImage);

  }
}


