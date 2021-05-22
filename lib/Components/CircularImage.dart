import 'package:flutter/material.dart';
class CircularImage extends StatelessWidget {
  final String image;
  final Function onPressed;
  final double width,height;

  const CircularImage({Key key, this.image,this.onPressed,this.width,this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 150.0,
        height:height ?? 150.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
          image: DecorationImage(
              image: image==null? AssetImage('images/profile.png'):NetworkImage(image),
              fit: BoxFit.fill
          ),
        ),
      ),
    );
  }
}
