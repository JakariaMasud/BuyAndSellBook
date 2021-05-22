import 'package:buy_book_app/Components/CircularImage.dart';
import 'package:buy_book_app/Components/CustomText.dart';
import 'package:buy_book_app/Components/PopUpMenu.dart';
import 'package:buy_book_app/Models/AppUser.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:buy_book_app/Services/ImagePickerService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      body:SingleChildScrollView(
        child: FutureBuilder<String>(
            future: DatabaseService.instance.getUserId(),
            builder: (context,idSnap){
              if(idSnap.connectionState!=ConnectionState.done){
                return SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 50.0,
                );
              }else{
                print('id : ${idSnap.data}');
                return StreamBuilder<DocumentSnapshot>(
                    stream: DatabaseService.instance.getProfileStream(idSnap.data),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        );
                      }else{
                        print('data : ${snapshot.data}');
                         AppUser user =AppUser.fromDocument(snapshot.data);
                        return Container(
                          margin: EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(child: user.profilePic==null ? CircularImage(onPressed: onImagePressed,) : CircularImage(image: user.profilePic,onPressed: onImagePressed,),),
                              CustomText(text: user.name,textColor: Colors.white,),
                              CustomText(text:"Designation : ${user.designation}",textColor: Colors.white),
                              CustomText(text:"Email  : ${user.email}",textColor: Colors.white),
                              CustomText(text:"Phone : ${user.phone}",textColor: Colors.white)

                            ],
                          ),
                        );
                      }
                    });
              }
            }),

      ),
    );
  }
  void onImagePressed() async {
    final pickedImage=await ImagePickerService.instance.pickImage(source: ImageSource.gallery);
    await DatabaseService.instance.updateProfilePic(pickedImage);


  }
}


