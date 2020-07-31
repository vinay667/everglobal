import 'dart:convert';

import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/screens/home.dart';
import 'package:everglobe/screens/sign_up_screen.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var textControllerUserName = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
            Column(
              children: <Widget>[
                SizedBox(height: 25),



                Image.asset('images/app_l.png',width: 80,height: 80,),


                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: Center(

                    child: TextWidget('LOG IN', MyColor.greyTextColor, 30),


                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, left: 56),
                  child: Text(
                    'Username',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(

                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerUserName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),

                        ),
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Image.asset(
                                'images/close.png', width: 10, height: 10),


                          )


                      )


                    ],


                  ),


                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, left: 56),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.greyTextColor,
                        decoration: TextDecoration.none,
                        fontFamily: 'GilroySemibold'),
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Stack(

                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Container(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontFamily: 'GilroySemibold'),
                            controller: textControllerPassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              border: InputBorder.none,


                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: MyColor.lightGreyTextColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: MyColor.boxBorder, width: 1),
                            color: Colors.white,
                          ),

                        ),
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Image.asset(
                                'images/close.png', width: 10, height: 10),


                          )


                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: (){
                    if(textControllerUserName.text=='' || textControllerPassword.text=='')
                      {
                        MySnackbar.displaySnackbar(key, Colors.blue, 'Please fill all fields');
                      }
                    else
                      {
                        loginUser();
                      }

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Card(
                      color: MyColor.themeColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: TextWidget('LOGIN', MyColor.whiteColor, 20),


                          )


                      ),


                    ),


                  ),


                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextWidget('', Colors.black87, 13),
                      TextWidget('FORGOT PASSWORD', Colors.black87, 13),


                    ],


                  ),


                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => SignUpSreen('register')));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      TextWidget(
                          "Don't  have account?", MyColor.greyTextColor, 14),
                      Text(
                        'Sign Up Here', style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold


                      ),


                      )


                    ],


                  ),

                )


              ],


            )


          ],


        ),


      ),


    );
  }

  Future<Map<String, dynamic>> loginUser() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Logging in...');
    try {
      http.Response response;
      response = await http.get(
          'http://api.123etl.net/API/Master/GetValidUser?vchUserID='+textControllerUserName.text+'&nvrPassword='+textControllerPassword.text,
 );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      List<dynamic> list=fetchResponse['Response']['UserDetails'];
      if(list.length==0)
        {
          MySnackbar.displaySnackbar(key, MyColor.noInternetColor, 'Invalid username/password');
        }
      else
        {
          print(fetchResponse['Response']['UserDetails'][0]['vchUserType']+'yui');
          _saveUserDetail(fetchResponse['Response']['UserDetails'][0]['vchUserID'],fetchResponse['Response']['UserDetails'][0]['vchUserType'], fetchResponse['Response']['UserDetails'][0]['intUserID'].toString(),fetchResponse['Response']['UserDetails'][0]['vchUserID'],fetchResponse['Response']['UserDetails'][0]['dtCreatedDate'].toString(),fetchResponse['Response']['UserDetails'][0]['vchCompanyName']);
          Toast.show('Login Successfully !', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(fetchResponse['Message'])),
              ModalRoute.withName("/home"));
        }

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      //Navigator.pop(context);
    }
  }

  _saveUserDetail(String email,String usertype,String userId,String userName,String registeredOn,String companyName)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('usertype', usertype);
    prefs.setString('userid', userId);
    prefs.setString('username', userName);
    prefs.setString('registered', registeredOn);
    prefs.setString('company', companyName);
  }

/*  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      loginUser();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }*/


}