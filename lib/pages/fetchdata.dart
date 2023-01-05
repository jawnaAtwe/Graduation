import 'package:untitled/pages/Sharedsession.dart';
import 'package:untitled/models/product1.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/pages/listitems.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled/models/GetLocation.dart';
import 'package:untitled/homm.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:untitled/pages/local_notification_service.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:highlight_text/highlight_text.dart';
import 'package:url_launcher/url_launcher.dart';
class fetchdata {


 static const String apiUrl = "http://192.168.1.65:3000/";


Future <List<CartItem>> wish1() async  {
  final prefs = await SharedPreferences.getInstance();
  String k=prefs.get("namename").toString() ;
  List<CartItem> mylist2;
    http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'showlist?username='+k),
  headers: {
'Content-Type':'application/json'

  }
       
 );


  if (res.statusCode == 200) {
   var jsonString = json.decode(res.body);
    List<CartItem> list = List<CartItem>.from(jsonString.map((i) => CartItem.fromJson(i)));
    mylist2= list;  

  } else {
    
    throw Exception('Failed to load album');
  }return mylist2;
}

Future <List<Product1>> showlistitem() async {
  List<Product1> myList2 =[];
  
    final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("current-list").toString() ;
    String A2=prefs.get("namename").toString() ;
    http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'listitems?listname='+A1+'&&userName='+A2),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
   var jsonString = json.decode(res.body);
    List<Product1> list =
        List<Product1>.from(jsonString.map((i) => Product1.fromJson(i)));

    myList2 = list;
  } else {
    
    throw Exception('Failed to load album');
  }return myList2;
}

Future <List<Product>> wish() async {
  late  List<Product> myList=[];

  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'wish'),
      headers: {'Content-Type': 'application/json'});

  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var jsonString = json.decode(res.body);
    List<Product> list =
        List<Product>.from(jsonString.map((i) => Product.fromJson(i)));
// List<Product> products = jsonString.map((jsonMap) => Product.fromJson(jsonMap)).toList();
    myList = list;
   
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  } return myList;
}

// login(n,p) async {

// await sessionManager.set("namename", n);
//         await sessionManager.set("passpass", p);
// }


Future  getinfo1() async {
  final prefs = await SharedPreferences.getInstance();
  String A=prefs.get("namename").toString() ;
  String B=prefs.get("passpass").toString() ;
var jsonString ;
    try {http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'infouser?username=' +
              A +
              '&&userpass=' +
             'B'),
          headers: {'Content-Type': 'application/json'});
       if (res.statusCode == 200) {
       jsonString = json.decode(res.body)as List;
       
     } else {
      // show error
      print("Try Again");
    }} catch (e) {
      print("no info");
    }
return jsonString;
}


 Future deletelist(String listname) async {
     final prefs = await SharedPreferences.getInstance();
     String A=prefs.get("namename").toString() ;
   try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'deletelist?listname=' +
              listname +
              '&&username=' +
              A 
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }
    
    
    }
 Future updateinfolist(String a,String b) async {
     final prefs = await SharedPreferences.getInstance();
  String username=prefs.get("namename").toString() ;
  String listname=prefs.get("current-listup").toString() ;
     try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'updatelist?username=' +
              username +
              '&&listname=' +
             listname+
             '&&listnamenew=' +
             a
             +
             '&&pricenew=' +
             b
             ),
          headers: {'Content-Type': 'application/json'});
   } catch (e) {
      print("no ");
    }


    
    }

Future login(String A,String B) async {

    try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'login?username=' +
              A +
              '&&userpass=' +
              B),
          headers: {'Content-Type': 'application/json'});
      if (res.body.contains("@")) {
       
        print("sucess");
        //class


        Sharedsession shared=new Sharedsession();
        await shared.savename(A,B);
       
      } else {
        print("failed1");
     
      }return res;
    } catch (e) {
      print('no');
    }

}






Future <List<user>>  online() async {
   List<user> list1;
  //  String A1=await SessionManager().get("current-list") ;
  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'usersonline'),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
  
    var jsonString = json.decode(res.body);
    list1 =
        List<user>.from(jsonString.map((i) => user.fromJson(i)));

   
  } else {
    
    throw Exception('Failed to load album');
  } return list1;
}

Future share(String n,String person) async {
  
     final prefs = await SharedPreferences.getInstance();
  String n2=prefs.get("namename").toString() ;
  String n1=prefs.get("current-list").toString() ;

  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'share?username='+n
  + '&&person=' +
              person 
               + '&&listname=' +
              n1+ '&&username1=' +
              n2 ),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
    print("oh");
   
  } else {
    
    throw Exception('Failed to load album');
  }
}
Future share1(String n,String person) async {
  
     final prefs = await SharedPreferences.getInstance();
  String n2=prefs.get("namename").toString() ;
  String n1=prefs.get("current-list").toString() ;

  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'share1?userName='+n
  + '&&person=' +
              person 
               + '&&listName=' +
              n1 + '&&userName1=' +
              n2),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
    print("oh");
   
  } else {
    
    throw Exception('Failed to load album');
  }
}


Future deleteitems(String nameproduct,int amount)async{
   final prefs = await SharedPreferences.getInstance();
  String n=prefs.get("namename").toString() ;
  String n1=prefs.get("current-list").toString() ;


  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'deleteproduct?username='+n
  + '&&listname=' +
              n1 +'&&nameproduct=' +
              nameproduct +'&&amount=' +
               '${amount}'
             ),

             
      headers: {'Content-Type': 'application/json'});
if (res.statusCode == 200) {
   } else {
    
    throw Exception('Failed to load album');
  }
}





Future   sendemail(String n1) async {
  final prefs = await SharedPreferences.getInstance();
  String n=prefs.get("namename").toString() ;
 
  //  String A1=await SessionManager().get("current-list") ;
  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'sendemail?username='+n
  + '&&listname=' +
              n1 
             ),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
//     final Email send_email = Email(
//   body: 'body of email',
//   subject: 'subject of email',
//   recipients: ['appetizingapplication@gmail.com'],
//   // cc: ['jawnaamjad@gmail.com'],
//   // bcc: ['jawnaamjad@gmail.com'],
//   // attachmentPaths: ['C:\Users\MIX-IT\Desktop\jo.txt'],
//   // isHTML: false,
// );

// String platformResponse;

//     try {
//       await FlutterEmailSender.send(send_email);
      
//     } catch (error) {
//       print("no email");
//     }
       
       
       var jsonString = json.decode(res.body);
    List<Product1> jawna = List<Product1>.from(jsonString.map((i) => Product1.fromJson(i)));
      String jojo='';
      int num=0;
      int i1=0;
      jojo=jojo+' ProductName '+'|  amount'+' | price\n';
       jojo=jojo+'\n';
      
        jawna.forEach((post) {
           
          jojo=jojo +(i1=i1+1).toString()+'. '+post.productName+' | '+ "\ ${post.amount}"+'  price--->'+ "\$ ${post.price}"+'\n';
        num=num+post.price;
        });
         jojo=jojo+'\n';
        
       jojo=jojo+' total price: '+num.toString();
      
      var url = 'mailto:appetizingapplication@gmail.com?subject=this is '+n+' order from Appetizing App&body=$jojo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    throw Exception('Failed to load album');
  }
}



Future <List<GetLocation>>  getlocation() async {
   List<GetLocation> list1;
 
  //  String A1=await SessionManager().get("current-list") ;
  http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'getlocation'),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
  
    var jsonString = json.decode(res.body);
    list1 = List<GetLocation>.from(jsonString.map((i) => GetLocation.fromJson(i)));

   
  } else {
    
    throw Exception('Failed to load album');
  } return list1;

}









}