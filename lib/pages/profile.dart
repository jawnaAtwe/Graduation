import 'package:untitled/pages/fetchdata.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/userprofile.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
import 'package:untitled/pages/fetchdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:untitled/homm.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'package:untitled/models/userprofile.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter_calendar_carousel/classes/event.dart';
 late String namejaw="";
late String passjaw="";
late String emailjaw="";
late String placejaw="";
late String phonejaw="";
fetchdata fetch1=new fetchdata();
  var jsonString;


class pro extends StatefulWidget {
  const pro({Key? key}) : super(key: key);
  @override
  State<pro> createState() => profilee();
  
}


class profilee extends State<pro> {

  @override
  void initState() {
    
  int h=1;
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    // do something
    getinfo();
 
    print("Build Completed"); 
  });
//     while(h==1)
//   {
// if(namejaw!="")h=0;
// else h=1;
//   
// }
  } 
   void getinfo() async {
jsonString=await fetch1.getinfo1();
namejaw=jsonString.elementAt(0)['username'];
passjaw=jsonString.elementAt(0)['userpass'];
emailjaw=jsonString.elementAt(0)['email'];
placejaw=jsonString.elementAt(0)['place'];
phonejaw=jsonString.elementAt(0)['phone'].toString();
print(namejaw);
  }
Widget build(BuildContext context) {
  
 return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.cyan[900],
      ),
        backgroundColor: Colors.cyan[900],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 40),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              Text(
                namejaw,
                style: TextStyle(
                  
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'assets/fonts/Pacifico-Regular.ttf',
                ),
              ),
              Text(
                "Buyer",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.grey,
                ),
              ),

              // we will be creating a new widget name info carrd
              Container( decoration: BoxDecoration(color: Colors.grey[500]!.withOpacity(0.4),
    border: Border.all(color: Colors.blueAccent), borderRadius: BorderRadius.circular(25.0),
  ),padding:  const EdgeInsets.symmetric(horizontal: 40.0),alignment: Alignment.center,
             child: new Column(
                        children: [SizedBox(height:20),
                 Row(children: [   Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),Text("    "+ namejaw ,style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 19.0,
                color: Colors.black),),],),
     SizedBox(height:20), Row(children: [ Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.white,
                            ),Text("    "+ emailjaw,style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 19.0,
                color: Colors.black),),],),

                SizedBox(height:20),
                  Row(children: [ Icon(
                              Icons.password,
                              size: 30,
                              color: Colors.white,
                            ),Text("    "+ passjaw ,style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 19.0,
                color: Colors.black),),],),
SizedBox(height:20),

                       Row(children: [ Icon(
                              Icons.place,
                              size: 30,
                              color: Colors.white,
                            ),Text("    "+ placejaw,style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 19.0,
                color: Colors.black),),],),  
                SizedBox(height:20),
                   Row(children: [ Icon(
                              Icons.phone,
                              size: 30,
                              color: Colors.white,
                            ),Text("    "+ phonejaw ,style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 19.0,
                color: Colors.black),),],),
                 SizedBox(height:170),
                  ]
                  )), 
              
                       
       
            ],
          ),
        ));
  }
}



