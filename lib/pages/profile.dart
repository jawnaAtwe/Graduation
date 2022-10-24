
import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:untitled/homm.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_calendar_carousel/classes/event.dart';

const url = "meshivanshsingh.me";
const email = "me.shivansh007@gmail.com";
const phone = "90441539202"; // not real number :)
const location = "Lucknow, India";
class pro extends StatefulWidget {
  const pro({Key? key}) : super(key: key);
  @override
  State<pro> createState() => profilee();
}

class profilee extends State<pro> {
  @override
  void initState() {
    
    super.initState();
  getinfo();
      setState(() {
      
      });
   
  }
Widget build(BuildContext context) {
return Scaffold(
        backgroundColor: Colors.cyan[900],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              Text(
                "Shivansh Singh",
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
              Container(alignment: Alignment.center,
                    child: new Column(
                        children: [
                 
                  ]
                  )), 
              
                       
              
              // InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              // InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
              // InfoCard(
              //     text: location,
              //     icon: Icons.location_city,
              //     onPressed: () async {}),
              // InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),
        ));
  }
}


  Future getinfo() async {
   
      String A=await SessionManager().get("namename") ;
        int B=await SessionManager().get("passpass") ;
        print( A);
        print(B);
    try {
    
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/infouser?username=' +
              A +
              '&&userpass=' +
             'B'),
          headers: {'Content-Type': 'application/json'});
  
    } catch (e) {
      print("no info");
    }
  }


  
