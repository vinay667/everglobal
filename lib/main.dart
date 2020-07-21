import 'package:everglobe/screens/home.dart';
import 'package:everglobe/screens/login_screen.dart';
import 'package:everglobe/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors/colors.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=await prefs.getString('userid') ?? 'notLogin';
  print(token);
  print(await prefs.getString('name'));
  runApp(MyApp(token));
}
class MyApp extends StatelessWidget {
  String token;
  MyApp(this.token);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.classyGreen
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(token),
      routes: {
        '/home': (BuildContext context) => HomeScreen(''),
        '/login': (BuildContext context) => LoginScreen(),
      },
    );
  }
}



