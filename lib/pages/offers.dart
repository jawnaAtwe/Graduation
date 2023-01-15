import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/offermodel.dart';
import 'package:untitled/models/market.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:convert';
import 'dart:io';

// import 'package:image_utils_class/image_utils_class.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:untitled/homm.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/pages/local_notification_service.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:highlight_text/highlight_text.dart';


TextEditingController productNameController = TextEditingController();
TextEditingController productImageURLController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productMarketController = TextEditingController();
TextEditingController productManufactureingController = TextEditingController();

 late int count=1;

   late  List<offermodel> myList=[];
  late  List<market> myListmenue=[];
   
   late String blob='';



    


void _runFilter(String enteredKeyword) {
  List<offermodel> results = [];
  if (enteredKeyword.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = myList;
  } else {
    results = myList
        .where((user) => user.productname
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();
    
  }

  myList = results;
  
}



class offer extends StatefulWidget {
  const offer({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<offer> {

 late final LocalNotificationService service;
 
  var OpenFile;
 
@override

  TextEditingController _textEditingController = TextEditingController();
  var _speechToText = stts.SpeechToText();
  bool isListening = false;
  String text = "";
  void listen() async {
    if (!isListening) {
      bool availiable = await _speechToText.initialize(
        onStatus: ((status) => print("$status")),
        onError: ((errorNotification) => print("$errorNotification")),
      );
      if (availiable) {
        setState(() {
          isListening = true;
        });
        _speechToText.listen(
            onResult: (result) => setState(() {
                  text = result.recognizedWords;
                  print(text);
                }));
      }
    } else {
      setState(() {
        isListening = false;
      });
      _speechToText.stop();
    }
  }

  @override
fetchdata fetch=new fetchdata();
  void initState()  {
    super.initState();

    service = LocalNotificationService();
    service.intialize();
 

    _speechToText = stts.SpeechToText();
    _textEditingController.text = text;
getPostsData();
    controller.addListener(() {
      double value = controller.offset / 125;

      setState(() {
       
        topContainer = value;
        closeTopContainer = controller.offset > 30;
      });
    });
  }

  ScrollController controller = ScrollController();

  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
   List<Widget> itemsData1 = [];
 void getlist() async{
  myList=await fetch.offer();
 }  
 void getlistadmin(String A) async{
 
   myList=await fetch.offeradmin(A);
   
   print(myList);
  getPostsData();
 }  
void getlist1() async{
  
var jsonString=await fetch.getinfo11();


 }



  void getPostsData() async{

 List<Widget> listItems1 = [];
    List<Widget> listItems = [];
      List<offermodel> A = [];
    if(myList.isEmpty)
myList=await fetch.offer();

myListmenue=await fetch.menue();

    myList.forEach((post) async {
  
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           
          children:<Widget>[Text(
                      post.productname,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    
                     SizedBox(
                      width: 20,
                    ),


                    
                    
                    ]),
                    Text(
                      post.marketname,
                      style: const TextStyle(fontSize: 17, color: Colors.red),
                    ),
                    Text(
                      post.date,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "\$ ${post.newprice}",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
             ),
                  ],
                ), Text(
                      post.offerratio,
                      style: const TextStyle(fontSize: 55, color: Colors.red),
                    ),

 ]
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
      itemsData1 = listItems1;

    });


      myListmenue.forEach((post) async {
    
    // Uint8List image = Base64Codec().decode(post.image);
// Uint8List image = Uint8List.fromList(post.image.toBytes());
      listItems1.add(Container(
        
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
          
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color.fromARGB(255, 221, 161, 71),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           
          children:<Widget>[Text(
                      post.AdminName,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    
                     SizedBox(
                      width: 20,
                    ),ElevatedButton(
                      child: Text('Show Product'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                    getlistadmin(post.AdminName);},
                    )
, ]),
                    Text(
                      post.city,
                 
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  
         
                  ],
                ),

 ]
            ),
          )));
    });
    
  }

 

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Offers'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSearchBar(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            heightFactor: 1,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]);
                      })),
            ],
          ),
        ),
        drawer: Drawer(
child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Expanded(
                  child: ListView.builder(
                    
                      controller: controller,
                      itemCount: itemsData1.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            heightFactor: 1,
                            alignment: Alignment.topCenter,
                            child: itemsData1[index]);
                      })),

]),


        ),
      ),
    );
  }

  _buildSearchBar() {
    return Row(
      children: <Widget>[
        AvatarGlow(
          glowColor: Colors.green,
          endRadius: 45.0,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          animate: isListening,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: FloatingActionButton.small(
            onPressed: () {
              listen();
            },
            child: const Icon(Icons.mic),
            backgroundColor: Color.fromARGB(255, 221, 161, 71),
          ),
        ), // avatarglow
ElevatedButton(
                      child: Text('All '),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                    
getlist();
getPostsData();
                      },
                    ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 30,
                    offset: const Offset(0, 5)),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: TextField(
              onChanged: (value) => {_runFilter(value),getPostsData(),getlist()},
              controller: _textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 7, 0, 0),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 9, 9, 9).withOpacity(0.30),
                  )),
            ),
          ),
        )),
      ],
    );
  }
}

  