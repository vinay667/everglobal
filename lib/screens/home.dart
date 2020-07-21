
import 'dart:convert';
import 'package:everglobe/colors/colors.dart';
import 'package:everglobe/constants/AppConstants.dart';
import 'package:everglobe/screens/login_screen.dart';
import 'package:everglobe/screens/profile_screen.dart';
import 'package:everglobe/screens/refine_search_screen.dart';
import 'package:everglobe/screens/view_item_screen.dart';
import 'package:everglobe/utils/api_dialog.dart';
import 'package:everglobe/utils/no_internet_check.dart';
import 'package:everglobe/utils/snackbar.dart';
import 'package:everglobe/widgets/home_item_widget.dart';
import 'package:everglobe/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'buy_screen.dart';
class HomeScreen extends StatefulWidget
{
  String token;
  HomeScreen(this.token);
  HomePageState createState()=>HomePageState(token);
}
class HomePageState extends State<HomeScreen>
{
  var textControllerSearch = new TextEditingController();
  String token;
  String userName,userEmail;
  bool loginVisible,logOutVisible;
  HomePageState(this.token);
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<String> widgetList = ['A', 'B', 'C'];
  int indexOfProduct=-1;
  String message,whatsappN,mailN,phoneN,userType;
  List<String> productNames=['Coveralls/PPE Kits','Goggles','Gloves','Face Shields','Shoe Cover','Mask','Thermometers','Oximeters','Covid 19 Testing Kits','Head Cover','Mask','Other'];
  List<String> productImages=['images/dummy1.jpg','images/dummy2.jpg','images/dummy3.jpg','images/dummy4.jpg','images/dummy5.jpg','images/dummy6.jpg','images/dummy7.jpg','images/dummy8.jpg','images/dummy9.jpg','images/dummy10.jpg','images/dummy6.jpg','images/dummy7.jpg'];
  List<dynamic> productList=[];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     key: key,
     drawer: Container(
       width: 250.3,
       child: Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: <Widget>[
             GestureDetector(
               onTap: () {
               },
               child: Container(
                 color: MyColor.navigationHeaderColor,
                 height: 200.3,
                 child: DrawerHeader(
                   padding: EdgeInsets.zero,
                   child: Container(
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(left: 15, top: 20),
                             child: Row(
                               children: <Widget>[
                                 Container(
                                   height: 60,
                                   width: 46.3,
                                   child: Stack(
                                     children: <Widget>[
                                       Container(
                                           height: 46.3,
                                           width: 46.3,
                                           margin: EdgeInsets.only(top: 10),
                                           decoration: new BoxDecoration(
                                               shape: BoxShape.circle,
                                               image: new DecorationImage(
                                                   fit: BoxFit.fill,
                                                   image: new AssetImage(
                                                       "images/girl_dp.jpg")))),

                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Container(
                               width: double.infinity,
                               padding:
                               EdgeInsets.only(left: 15, top: 20, right: 4),
                               child: Text(
                                 userName ?? '',
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     fontSize: 16,
                                     fontFamily: 'GilroySemibold',
                                     color: Colors.white),
                               )),
                           Container(
                               width: double.infinity,
                               padding:
                               EdgeInsets.only(left: 15, top: 7, right: 5),
                               child: Text(
                                 userEmail ?? '',
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     fontSize: 12,
                                     fontFamily: 'GilroySemibold',
                                     color: Colors.white),
                               )),
                         ],
                       )),
                 ),
               ),
             ),



            token=='notLogin'?
             ListTile(
               title: Text(
                 'Login',
                 style: TextStyle(
                     fontSize: 16,
                     color: MyColor.textBlueColor,
                     decoration: TextDecoration.none,
                     fontFamily: 'GilroySemibold'),
               ),
               onTap: () {


                 Navigator.push(context, CupertinoPageRoute(builder:(context)=>LoginScreen()));


               },
             ):Container(),
             token!='notLogin'?
             ListTile(
               title: Text(
                 'Profile',
                 style: TextStyle(
                     fontSize: 16,
                     color: MyColor.textBlueColor,
                     decoration: TextDecoration.none,
                     fontFamily: 'GilroySemibold'),
               ),
               onTap: () {

                 Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProfileScreen()));



               },
             ):Container(),
             ListTile(
               title: Text(
                 'About Us',
                 style: TextStyle(
                     fontSize: 16,
                     color: MyColor.textBlueColor,
                     decoration: TextDecoration.none,
                     fontFamily: 'GilroySemibold'),
               ),
               onTap: () {},
             ),
             ListTile(
               title: Text(
                 'Contact Us',
                 style: TextStyle(
                     fontSize: 16,
                     color: MyColor.textBlueColor,
                     decoration: TextDecoration.none,
                     fontFamily: 'GilroySemibold'),
               ),
               onTap: () {},
             ),



             token=='notLogin'?Container():
             ListTile(
               title: Text(
                 'Log Out',
                 style: TextStyle(
                     fontSize: 16,
                     color: MyColor.textBlueColor,
                     decoration: TextDecoration.none,
                     fontFamily: 'GilroySemibold'),
               ),
               onTap: () {
                 showLogOutDialog(context);
               },
             ),
           ],
         ),
       ),
     ),
    body: Builder(
      builder: (ctx)=>SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 55,
              color: MyColor.themeColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){

                      Scaffold.of(ctx).openDrawer();
                    },
                    child: Padding(
                      padding:EdgeInsets.only(left: 15),
                      child: Image.asset('images/hamber2.png',width: 25,height: 25,color: Colors.white),
                    ),

                  ),
                  Padding(
                    padding:EdgeInsets.only(right: 20),
                    child: Image.asset('images/app_l.png',width: 40,height: 50,color: Colors.white),
                  ),




                ],



              ),



            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     GestureDetector(
                       onTap: (){
                         if(token=='notLogin')
                         {
                           showLogInDialog(context);
                         }
                         else
                         {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen('SELL','','','','','')));
                         }

                       },
                       child:  Container(
                           decoration: BoxDecoration(
                             color: MyColor.themeColor,
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(
                                 color: MyColor.boxBorder, width: 0.5),


                           ),

                           child: Padding(
                             padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                             child: TextWidget('POST SELLING OFFER',Colors.white,12),
                           )
                       ),
                     ),

                      SizedBox(width: 10),
                     GestureDetector(
                       onTap: (){
                         if(token=='notLogin')
                         {
                           showLogInDialog(context);
                         }
                         else
                         {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyScreen('BUY','','','','','')));
                         }
                       },

                       child:  Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(
                                 color: MyColor.boxBorder, width: 0.5),
                           ),

                           child: Padding(
                             padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                             child: TextWidget('POST BUYING REQUEST',Colors.black87,12),


                           )
                       ),
                     )

                    ],



                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(

                        onTap: (){


                          if(token=='notLogin')
                          {
                            showLogInDialog(context);
                          }
                          else
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SELLING OFFERS','View','seller')));

                          }


                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: MyColor.boxBorder, width: 0.5),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                              child: TextWidget('VIEW SELLING OFFER',Colors.black87,12),


                            )
                        ),
                      ),
//
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: (){

                          if(token=='notLogin')
                          {
                            showLogInDialog(context);
                          }
                          else
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('BUYING REQUEST','View','buyer')));

                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: MyColor.boxBorder, width: 0.5),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                              child: TextWidget('VIEW BUYING REQUESTS',Colors.black87,12),
                            )
                        ),

                      )

                    ],



                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: Stack(

                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(left: 33, right: 33, top: 5),
                          child: Container(
                            child: TextFormField(
                              controller: textControllerSearch,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 10.0),
                                border: InputBorder.none,
                                hintText: 'What are you looking for ?',
                                hintStyle: TextStyle(
                                    color: MyColor.lightGreyTextColor,
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'GilroySemibold'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: MyColor.boxBorder, width: 0.5),
                              color: Colors.white,
                            ),

                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(token=='notLogin')
                            {
                              showLogInDialog(context);
                            }
                            else
                            {


                              if(textControllerSearch.text=='')
                                {

                                  MySnackbar.displaySnackbar(key, MyColor.noInternetColor, 'Enter search text');



                                }
                              else
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','search',textControllerSearch.text)));
                                }
                            }
                          },

                          child: Padding(
                            padding: EdgeInsets.only(top: 5,right: 33),
                            child:  Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight:Radius.circular(30) ),
                                    color: MyColor.themeColor,
                                  ),
                                  child: Center(
                                    child: Image.asset('images/icon_search.png',width: 25,height: 25,color: Colors.white),


                                  ),


                                )


                            ),


                          ),

                        )


                      ],


                    ),


                  ),



                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS')));
                    },

                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Row(

                        children: <Widget>[

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                            },
                            child: HomeItemWidget('MASK'),

                          ),
                          SizedBox(width: 7,),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','Coveralls')));
                            },
                            child: HomeItemWidget('Coveralls/PPE Kits'),

                          ),
                          SizedBox(width: 7,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','gloves')));
                            },
                            child: HomeItemWidget('Gloves'),

                          ),
                          SizedBox(width: 7,),
                      /*    GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                            },
                            child: HomeItemWidget('MASK'),

                          ),*/
                        ],


                      ),


                    ),


                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS')));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Row(

                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','Hand Sanitizer')));
                            },
                            child: HomeItemWidget('Hand Sanitizer'),

                          ),
                          SizedBox(width: 7,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','testing kits')));
                            },
                            child: HomeItemWidget('Covid19 Testing kits'),

                          ),
                          SizedBox(width: 7,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                            },
                            child: HomeItemWidget('MASK'),

                          ),
                          SizedBox(width: 7,),

                        ],


                      ),


                    ),


                  ),
                  SizedBox(height: 10),
                 GestureDetector(

                   onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS')));
                   },
                   child:  Padding(
                     padding: EdgeInsets.only(left: 20,right: 20),
                     child: Row(

                       children: <Widget>[


                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','goggles')));
                           },
                           child: HomeItemWidget('Goggles/Face Shields'),

                         ),
                         SizedBox(width: 7,),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','Shoe Cover')));
                           },
                           child: HomeItemWidget('Shoe Cover/Head Cover'),

                         ),






                       ],


                     ),


                   ),


                 ),
                  SizedBox(height: 10),
                 GestureDetector(
                   onTap: (){
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS')));

                   },
                   child:  Padding(
                     padding: EdgeInsets.only(left: 20,right: 20),
                     child: Row(

                       children: <Widget>[
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','Oximeters')));
                           },
                           child: HomeItemWidget('Thermometers/Oximeters'),

                         ),
                         SizedBox(width: 7,),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','Ventilators')));
                           },
                           child: HomeItemWidget('Ventilators'),

                         ),
                         SizedBox(width: 7,),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','other')));
                           },
                           child: HomeItemWidget('Other'),

                         ),

                       ],


                     ),


                   ),


                 ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child:
                    GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                    childAspectRatio: 2/2.5/*MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/4)*/
                    ),
                        itemCount: productImages.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context,int position)
                    {

                      return GestureDetector(
                        onTap: (){

                          if(token=='notLogin')
                          {
                            showLogInDialog(context);
                          }
                          else
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                          }
                        },

                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height:60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColor.themeColor,
                                ),

                                child: Center(

                                    child:  Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(productImages[position],width: 55,height: 45,),
                                      ),
                                    )

                                ),


                              ),




                              SizedBox(height:5),

                              Text(
                                productNames[position],
                                style: TextStyle(fontSize: 12,color: MyColor.greyTextColor,fontFamily: 'GilroySemibold'),
                              )


                            ],



                          ),
                        ),
                      );

                    })


                    /*GridView.count(
                      crossAxisCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: productImages.map((String value) {
                        indexOfProduct=indexOfProduct+1;
                        return new  GestureDetector(
                          onTap: (){
                            if(token=='notLogin')
                            {
                              showLogInDialog(context);
                            }
                            else
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen('SEARCH RESULTS','cat','mask')));
                            }


                          },
                          child: Container(
                            color: Colors.lightBlue,
                            height: 80,
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColor.themeColor,
                                  ),

                                  child: Center(

                                      child:  Padding(
                                        padding: EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(value,width: 55,height: 45,),
                                        ),
                                      )

                                  ),


                                ),




                                SizedBox(height:5),

                                indexOfProduct<=11? Text(
                                  productNames[indexOfProduct],
                                  style: TextStyle(fontSize: 12,color: MyColor.greyTextColor,fontFamily: 'GilroySemibold'),
                                ):Text('Mask tef qdvytqd qtdqeytd dtyqfd gwdwqd ',style: TextStyle(fontSize: 12,color: MyColor.greyTextColor,fontFamily: 'GilroySemibold'))







                              ],



                            ),
                          )

                        );
                      }).toList(),
                    ),*/
                  ),


                  Divider(color: MyColor.dividerColor),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextWidget('Latest Leads',MyColor.greyTextColor,20),
                  ),

                  SizedBox(height: 10),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context,int position)
                      {
                        return Padding(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 7,bottom: 7),
                          child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 15,top: 10,right: 10),
                                      child: Text(
                                        productList[position]['vchDescriptions'],
                                        style: TextStyle(fontSize: 15,color: MyColor.textColorBlue,fontFamily: 'GilroySemibold'),
                                      ),
                                    ),
                                    Divider(
                                      color: MyColor.dividerColor,
                                    ),
                                    Container(

                                      child: Row(
                                        children: <Widget>[


                                          Expanded(
                                            child: Padding(
                                              padding:EdgeInsets.all(5),
                                              child:  FadeInImage.assetNetwork(
                                                height: 30,
                                                width: 60,
                                                placeholder: 'images/launcher_icon.png',
                                                image: AppConstants.imageBaseUrl+productList[position]['ImgPath'],
                                              )
                                            ),

                                            flex: 1,
                                          ),


                                          Container(color: MyColor.dividerColor,width: 1,height:38,),
                                          Expanded(
                                            child: Center(
                                                child: TextWidget(productList[position]['vchUserType'],Colors.brown,16)
                                            ),
                                            flex: 1,
                                          ),

                                          Container(color: MyColor.dividerColor,width: 1,height:38,),


                                          Expanded(
                                            child: Center(
                                                child: InkWell(
                                                  onTap: (){


                                                    if(token=='notLogin')
                                                      {

                                                        showLogInDialog(context);
                                                      }
                                                    else
                                                      {

                                                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ViewItemScreen(productList[position]['intProductId'].toString())));


                                                      }

                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: MyColor.classyGreen,
                                                      ),
                                                      width: 90,
                                                      height: 40,
                                                      child: Center(
                                                        child: TextWidget('View Item',Colors.white,15),

                                                      )



                                                  ),


                                                )
                                            ),
                                            flex: 1,
                                          )







                                        ],



                                      ),

                                    ),
                                    Divider(
                                      color: MyColor.dividerColor,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              launchWhatsApp(productList[position]['vchWhatsAppNo'].toString());
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Image.asset('images/whatsapp.png',width: 40,height: 40,),
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),

                                        Container(color: MyColor.dividerColor,width: 1,height:38,),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){


                                              _launchURL(productList[position]['vchUserID'],'', '');


                                              //detr
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Image.asset('images/mail.png',width: 40,height: 40,),
                                              ),
                                            ),
                                          ),
                                          flex: 1,

                                        ),

                                        Container(color: MyColor.dividerColor,width: 1,height:38,),
                                        Expanded(
                                          child:GestureDetector(
                                            onTap: (){
                                              _makePhoneCall('tel:'+productList[position]['vchMobileNo']);

                                            },
                                            child:  Container(
                                              child: Center(
                                                child: Image.asset('images/call.png',width: 35,height: 35,),
                                              ),
                                            ),

                                          ),
                                          flex: 1,

                                        ),










                                      ],


                                    ),
                                    SizedBox(height: 7,)





                                  ],



                                ),
                              )




                          ),


                        );
                      }


                  ),

                  SizedBox(height: 10,)
















                ],

              ),

            )


          ],


        ),


      ),


    )


);


  }

  Future<Map<String, dynamic>> fetchProductList() async {
    APIDialog.showAlertDialog(context, 'Fetching Posts...');

    String message = '';
    try {
      http.Response response;
      response = await http.get(
          'http://api.123etl.net/API/Master/GetLatestPosts',
         );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        productList=fetchResponse['Response']['LatestPosts'];
        indexOfProduct=-1;

      });

      print(fetchResponse);

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchProductList();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(token=='notLogin')
      {

      }
    else
      {
        _fetchUserDetails();
        setState(() {
          logOutVisible=true;
          loginVisible=false;
        });
      }


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

  showLogInDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes,Login"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, CupertinoPageRoute(builder:(context)=>LoginScreen()));


      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log in"),
      content: Text("To view items you need to login !"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showLogOutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName("/home"));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to Log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  
  
  _fetchUserDetails()async{
    
    SharedPreferences prefs=await SharedPreferences.getInstance();
   setState(() {
     userName=prefs.getString('access_token');
     userEmail=prefs.getString('email');
   });
    
  }


}