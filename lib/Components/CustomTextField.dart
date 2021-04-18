import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.size,
    @required this.controller,
    this.icon,
    @required this.hintText,
    @required this.textInputType,
    this.obscureText=false
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final Icon icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width*0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.0,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29.0),
        border: Border.all(color: Colors.blue),
      ),
      child: icon==null? TextField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
        ),
      ) :TextField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            icon:icon
        ),
      )
    );
  }
}