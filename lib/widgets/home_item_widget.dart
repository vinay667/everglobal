
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeItemWidget extends StatelessWidget
{
  String text;
  HomeItemWidget(this.text);
  @override
  Widget build(BuildContext context) {

    return  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: MyColor.boxBorder, width: 0.5),
        ),

        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
          child: TextWidget(text,Colors.black87,12),


        )
    );
  }
}