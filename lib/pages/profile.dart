
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
            

            
      // Userprofile record = Userprofile.fromJson(jsonDecode(value.body));
      // setState(() {
      //   namejaw =
      //   record.records!.elementAt(0).totalRate.toString().substring(0, 3);
        
      // });
         
//  final data = json.decode(res.body);
//  namejaw= data['username'];
   
  
    if (res.statusCode == 200) {
      var jsonString = json.decode(res.body)as List;
      // jsonDecode(res.body).map((item) => Userprofile.fromJson(item));

namejaw=jsonString.elementAt(0)['username'];
passjaw=jsonString.elementAt(0)['userpass'];
emailjaw=jsonString.elementAt(0)['email'];
placejaw=jsonString.elementAt(0)['place'];
phonejaw=jsonString.elementAt(0)['phone'].toString();


print(namejaw);
    // List<Userprofile> list1 = List<Userprofile>.from(jsonString.map((i) => Userprofile.fromJson(i)));
   
    //   Map<String, dynamic> res1 = json.decode(res.body) ;
    
      //insert data into ModelClass
      //  final  Userprofile _jawnaa = Userprofile.fromJson(res1);
      //   namejaw=_jawnaa.username;
   
        // var jsonString = json.decode(res.body);
    // List<Userprofile> list1= List<Userprofile>.from(jsonString.map((i) => Userprofile.fromJson(i)));
 
    } else {
      // show error
      print("Try Again");
    }
   
   
   
    } catch (e) {
      print("no info");
    }
  }

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

//   }
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



