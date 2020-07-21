import 'dart:convert';
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/constants/AppConstants.dart';
import 'package:everglobe/screens/sign_up_screen.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'buy_screen.dart';
import 'view_item_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String userEmail = '';
  String userId = '';
  String userType = '';
  String registeredOn = '';
  List<dynamic> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 25),
                  Text(
                    'MY ACCOUNT',
                    style: TextStyle(
                        fontSize: 25,
                        color: MyColor.greyTextColor,
                        fontFamily: 'GilroySemibold'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'images/user.png',
                            width: 100,
                            height: 100,
                          ),

                          SizedBox(height: 10),

                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextWidget(userEmail, Colors.black, 15),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: (){

                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignUpSreen('update')));

                                  },
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: MyColor.themeColor,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'images/edit.png',
                                          width: 13,
                                          height: 13,
                                          color: Colors.white,
                                        ),
                                      )),

                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 15),

                          Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset('images/register.png',
                                        width: 20, height: 20),
                                    SizedBox(width: 7),
                                    TextWidget(registeredOn,
                                        MyColor.greyTextColor, 15),
                                  ],
                                ),
                                TextWidget(
                                    '12-06-2020', MyColor.greyTextColor, 15),
                              ],
                            ),
                          ),

                          //SizedBox(height: 15),
                          Divider(
                            color: MyColor.dividerColor,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset('images/user_type.png',
                                        width: 20, height: 20),
                                    SizedBox(width: 7),
                                    TextWidget(
                                        'User Type', MyColor.greyTextColor, 15),
                                  ],
                                ),
                                TextWidget(userType, MyColor.greyTextColor, 15),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  list.length != 0
                      ? Text(
                          'LEAD DETAILS',
                          style: TextStyle(
                              fontSize: 18,
                              color: MyColor.greyTextColor,
                              fontFamily: 'GilroySemibold'),
                          textAlign: TextAlign.left,
                        )
                      : Text(''),
                  SizedBox(height: 5),
                  ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int position) {
                        return Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: FadeInImage.assetNetwork(
                                      height: 40,
                                      width: 60.0,
                                      placeholder: 'images/launcher_icon.png',
                                      image: AppConstants.imageBaseUrl +
                                          list[position]['ImgPath'],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 100,
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        list[position]['vchTitle'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: MyColor.greyTextColor,
                                            fontFamily: 'GilroySemibold'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  SizedBox(width: 7),
                                  GestureDetector(
                                    onTap: () {
                                      deleteUserPost(list[position]
                                              ['intProductId']
                                          .toString());
                                    },
                                    child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyColor.lightGreyTextColor,
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          'images/delete.png',
                                          width: 13,
                                          height: 13,
                                          color: Colors.black,
                                        ))),
                                  ),
                                  SizedBox(width: 7),
                                  GestureDetector(
                                    onTap: (){

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen('UPDATE',list[position]['intProductId'].toString(),list[position]['vchTitle'],list[position]['vchCategory'],list[position]['vchDescriptions'],list[position]['vchUserType'])));


                                    },

                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: MyColor.lightGreyTextColor,
                                      ),
                                      child: Center(
                                          child: Image.asset(
                                            'images/edit.png',
                                            width: 13,
                                            height: 13,
                                            color: Colors.black,
                                          )),
                                    ),

                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                 GestureDetector(
                                   onTap: (){
                                     Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewItemScreen(list[position]['intProductId'].toString())));

                                   },

                                   child:  Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(5),
                                         color: MyColor.classyGreen,
                                       ),
                                       width: 75,
                                       height: 30,
                                       child: Center(
                                         child: TextWidget(
                                             'View Item', Colors.white, 13),
                                       )),


                                 )
                                ],
                              ),
                            ));
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email');
      userId = prefs.getString('userid');
      registeredOn = prefs.getString('registered');
      userType = prefs.getString('usertype');
    });

    checkInternetAPIcall();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<Map<String, dynamic>> getUserPosts() async {
    print(userId + 'eff');
    String message = '';
    APIDialog.showAlertDialog(context, 'Fetching Posts...');
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/GetPostsByUserID?intUserID=' + userId,
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        list = fetchResponse['Response']['PostsByUserID'];
      });

      if (list.length == 0) {
        Toast.show(
          'No Posts found !!',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.lightBlue,
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      //Navigator.pop(context);
    }
  }

  Future<Map<String, dynamic>> deleteUserPost(String productId) async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Removing Post...');
    try {
      http.Response response;
      response = await http.post(
        'http://api.123etl.net/API/Master/DeleteLeadPostByID?intProductId=' +
            productId +
            '&intCreatedBy=1',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);

      if (fetchResponse['Status'].toString() == 'true') {
        Toast.show(
          fetchResponse['Message'],
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.lightBlue,
        );
        getUserPosts();
      } else {
        Toast.show(
          fetchResponse['Message'],
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.lightBlue,
        );
      }

      Navigator.of(context, rootNavigator: true).pop();
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      Toast.show(
        'Delete Post successfully.',
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.lightBlue,
      );
      getUserPosts();

      //Navigator.pop(context);
    }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getUserPosts();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }
}
