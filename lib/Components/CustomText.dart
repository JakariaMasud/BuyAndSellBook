import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final double padding;

  const CustomText({Key key, @required this.text,this.textColor,this.textSize,this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  padding!=null? EdgeInsets.all(padding):EdgeInsets.all(18.0),
      child: Text(text,style: TextStyle(fontSize: textSize ?? 18.0,fontWeight: FontWeight.normal,color: textColor ?? Colors.black),),
    );
  }
}
