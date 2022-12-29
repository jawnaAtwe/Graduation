import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
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

import 'package:untitled/pages/local_notification_service.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:highlight_text/highlight_text.dart';


TextEditingController productNameController = TextEditingController();
TextEditingController productImageURLController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productMarketController = TextEditingController();
TextEditingController productManufactureingController = TextEditingController();



   late  List<user> myList=[];


    


void _runFilter(String enteredKeyword) {
  List<user> results = [];
  if (enteredKeyword.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = myList;
  } else {
    results = myList
        .where((user) => user.username
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();
    // we use the toLowerCase() method to make it case-insensitive
  }

  myList = results;
}

void share(String person) async {
  myList=await fetch.share(person);
   
}
void share1(String person) async {
  myList=await fetch.share1(person);
}
class users extends StatefulWidget {
  const users({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<users> {

 late final LocalNotificationService service;
  


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

  void initState() {
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
void getlist() async{
  myList=await fetch.online();
 }
  void getPostsData() async{
   List<Widget> listItems = [];
      List<user> A = [];
    if(myList.isEmpty)
myList=await fetch.online();
   
    myList.forEach((post) {
      listItems.add(Container(
          height: 110,
          
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color.fromARGB(255, 221, 161, 71),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.username,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 209, 224, 199),),
                    ),
                    Text(
                      post.email,
                      style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 209, 224, 199),),
                    ),
                 ],
                ),
                // Image.asset(
                //   "assets/images/${post.imageUrl}.png",
                //   height: double.infinity,
                     Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[    ElevatedButton(
                child: Text('Share  my  List'),
                style: ElevatedButton.styleFrom(
                 
                   primary: Color.fromARGB(255, 209, 224, 199),
           
                  onPrimary: Color.fromARGB(255, 221, 161, 71),
                  onSurface: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: () {
                 share(post.username);
                  share1(post.username);
                },
              )
                , ElevatedButton(
                child: Text('Send Massege'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 209, 224, 199),
                 
                  onPrimary: Color.fromARGB(255, 221, 161, 71),
                  onSurface: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: () {
                  
                },
              )   
             
                     ])   // )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
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
          title: const Text('Shopping'),
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
      ),
    );
  }

  _buildSearchBar() {
    return Row(
      children: <Widget>[
  

        Expanded(
            child: Container(
          decoration: BoxDecoration(
            
              color: Color.fromARGB(255, 209, 224, 199),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 30,
                    offset: const Offset(0, 5)),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: TextField(
              onChanged: (value) =>{_runFilter(value),getPostsData(),getlist()},
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


  