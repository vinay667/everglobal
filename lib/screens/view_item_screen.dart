
import 'dart:convert';

import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/constants/AppConstants.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ViewItemScreen extends StatefulWidget{
  String productId;
  ViewItemScreen(this.productId);

  ViewItemState createState()=>ViewItemState(productId);
}

class ViewItemState extends State<ViewItemScreen>
{
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  String productId;
  List<dynamic> list=[];
  ViewItemState(this.productId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset('images/bg_sign_in.png', fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 25),
                  Text(
                    'VIEW ITEM',
                    style: TextStyle(
                        fontSize: 25,
                        color: MyColor.greyTextColor,
                        fontFamily: 'GilroySemibold'),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 25),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: MyColor.themeColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                            ),

                            child: Center(
                              child:list.length!=0?
                              Text(
                                list[0]['vchTitle'],
                                style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                              ):Text(''),


                            ),





                          ),
                          SizedBox(height: 10),

                          list.length!=0?
                          FadeInImage.assetNetwork(
                            height: 120,
                            width: 120,
                            placeholder: 'images/launcher_icon.png',
                            image: AppConstants.imageBaseUrl+list[0]['ImgPath'],
                          ):Container( height: 120,
                            width: 120),
                          SizedBox(height: 10),





                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 15),
                            child:  Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'GilroySemibold'),
                            ),


                          ),

                          SizedBox(height: 10,),


                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 15,right: 15),
                            child:
                            list.length!=0?
                            Text(
                              list[0]['vchDescriptions'],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: MyColor.greyTextColor,
                                  fontFamily: 'GilroySemibold'),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ):Text('')
                          ),
                          SizedBox(height: 12),








                        ],


                      ),


                    ),


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


                          SizedBox(height: 10,),
                          Image.asset('images/user.png',width: 100,height: 100,),

                          SizedBox(height: 10),

                          Container(
                            width: double.infinity,
                            child:  Row(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[


                                list.length!=0?
                                TextWidget(list[0]['vchUserID'],Colors.black,15):Text(''),
                                SizedBox(width: 5),
                                Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyColor.themeColor,
                                    ),
                                    child: Center(
                                      child: Image.asset('images/edit.png',width: 13,height: 13,color: Colors.white,),


                                    )





                                )

                              ],



                            ),

                          ),

                          SizedBox(height: 5),
                          Center(

                            child: list.length!=0?
                            TextWidget(list[0]['vchCountry']+','+list[0]['vchCity']+','+list[0]['vchZipCode'].toString(),Colors.black,15):Text('')
                          ),
                          SizedBox(height: 20),

                          Padding(
                            padding: EdgeInsets.only(left: 12,right: 12),
                            child:  GestureDetector(
                              onTap: (){

                                launchWhatsApp(list[0]['vchWhatsAppNo'].toString());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Container(
                                          width: 22,
                                          height: 22,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColor.lightGreyTextColor,
                                          ),
                                          child: Center(
                                              child: Image.asset('images/whatsapp2.png',width: 13,height: 13,color: Colors.black,)

                                          )
                                      ),

                                      SizedBox(width: 7),

                                      TextWidget('WhatsApp',MyColor.greyTextColor,15),









                                    ],


                                  ),

                                  list.length!=0?
                                  TextWidget(list[0]['vchWhatsAppNo']??'NA',MyColor.greyTextColor,15):Text('')









                                ],


                              ),


                            )


                          ),


                          Divider(
                            color: MyColor.dividerColor,


                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12,right: 12),
                            child:  GestureDetector(
                              onTap: (){
                                _makePhoneCall('tel:'+list[0]['vchMobileNo']);


                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Container(
                                          width: 22,
                                          height: 22,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColor.lightGreyTextColor,
                                          ),
                                          child: Center(
                                              child: Image.asset('images/call2.png',width: 13,height: 13,color: Colors.black,)

                                          )





                                      ),

                                      SizedBox(width: 7),

                                      TextWidget('Mobile',MyColor.greyTextColor,15),









                                    ],


                                  ),

                                  list.length!=0?
                                  TextWidget(list[0]['vchMobileNo'].toString()??'NA',MyColor.greyTextColor,15):Text('')









                                ],


                              ),

                            )


                          ),


                          Divider(
                            color: MyColor.dividerColor,


                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 12,right: 12),
                            child:  GestureDetector(
                              onTap: (){
                                _launchURL(list[0]['vchUserID'],'', '');
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Container(
                                          width: 22,
                                          height: 22,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColor.lightGreyTextColor,
                                          ),
                                          child: Center(
                                              child: Image.asset('images/mail2.png',width: 13,height: 13,color: Colors.black,)

                                          )





                                      ),

                                      SizedBox(width: 7),

                                      TextWidget('Mail',MyColor.greyTextColor,15),









                                    ],


                                  ),

                                  list.length!=0?
                                  TextWidget(list[0]['vchUserID'],MyColor.greyTextColor,15):Text('')









                                ],


                              ),

                            )


                          ),
                          SizedBox(height: 8,)


















                        ],


                      ),


                    ),


                  ),

                  SizedBox(height: 15),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(

                      children: <Widget>[
                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 12,right: 12),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[

                                  Image.asset('images/register.png',width: 20,height: 20),

                                  SizedBox(width: 7),

                                  TextWidget('Posted On',MyColor.greyTextColor,15),









                                ],


                              ),

                              list.length!=0?
                              TextWidget(list[0]['dtCreatedDate'],MyColor.greyTextColor,15):Text('')









                            ],


                          ),


                        ),


                        SizedBox(height: 15),

                        Padding(
                          padding: EdgeInsets.only(left: 12,right: 12),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[

                                  Image.asset('images/user_type.png',width: 20,height: 20),

                                  SizedBox(width: 7),

                                  TextWidget('User Type',MyColor.greyTextColor,15),









                                ],


                              ),

                              list.length!=0?
                              TextWidget(list[0]['vchUserType'],MyColor.greyTextColor,15):Text('')
                            ],


                          ),


                        ),
                        SizedBox(height: 10),



                      ],


                    ),

                  ),
                  SizedBox(height: 15),







                ],



              ),


            )


          ],


        )



      ),





    );
  }

  Future<Map<String, dynamic>> getProductDetail() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Fetching Details...');
    try {
      http.Response response;
      response = await http.get(
        'http://api.123etl.net/API/Master/getProductDetails_ById?intProductId='+productId,
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        list=fetchResponse['Response']['ProductDetails'];
      });

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
      //Navigator.pop(context);
    }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getProductDetail();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }
  Future<void> launchWhatsApp(String phone) async {
    if (await canLaunch("https://api.whatsapp.com/send?phone=" + phone)) {
      await launch("https://api.whatsapp.com/send?phone=" + phone);
    }
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

