
import 'dart:async';
import 'package:everglobe/widgets/slider_layout_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
class SplashScreen extends StatefulWidget {
  String token;
  SplashScreen(this.token);
  @override
  _SplashScreenState createState() => _SplashScreenState(token);
}

class _SplashScreenState extends State<SplashScreen> {
  String token;
  _SplashScreenState(this.token);
  @override
  void initState() {
    super.initState();//28c17e
    Timer(
        Duration(seconds: 3),
            () =>
                token=='notLogin'?
                Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SliderLayoutView())):
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(token)))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('images/splash_screen.png',fit: BoxFit.fill,),
        )



      )
    );
  }
}