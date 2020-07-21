import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SlideItem extends StatelessWidget {
  final int index;
  List<String> imagesList=['images/intro_screen_1.png','images/intro_screen_2.png','images/intro_screen_3.png'];
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
     child: Image.asset(imagesList[index]),
    );
  }
}