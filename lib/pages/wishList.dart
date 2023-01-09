import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
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

   late  List<Product> myList=[];

void _runFilter(String enteredKeyword) {
  List<Product> results = [];
  if (enteredKeyword.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = myList;
  } else {
    results = myList
        .where((user) => user.productName
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();
    
  }

  myList = results;
  
}


class WishList1 extends StatefulWidget {
  const WishList1({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WishList1> {

 late final LocalNotificationService service;
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

    }
  }
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
 void getlist() async{
  myList=await fetch.most();
 }  

  void getPostsData() async{
   
    List<Widget> listItems = [];
      List<Product> A = [];
    if(myList.isEmpty)
myList=await fetch.most();

    myList.forEach((post) {
    
    

      listItems.add(Container(
          height: 100,
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.productName,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.marketName,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    Text(
                      post.manufacturing,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post.price}",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           
          children:<Widget>[
            


          ]),
                  ],
                ),
                Image.asset(post.image,width: 100,height: 80,),

               
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
          title: const Text('Appetizing App :)'),
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
              ),Container(
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
           margin: EdgeInsets.all(
                              2
                              ),
          height: 200.0,
          
          child: ListView(
            // This next line does the trick.
            
          
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              //  Image.asset("assets/images/of_main_bg.png",
                                        
              //                           ),
              //                             Image.asset("assets/images/of_main_bg.png",
              //                           height: 100, width: 120
              //                           ),
              //                             Image.asset("assets/images/b.jpg",
              //                           height: 100, width: 120
              //                           ),
              Container(
           
                margin: EdgeInsets.all(
                              5
                              ),width: 150,
               decoration: BoxDecoration(
                 image: DecorationImage(
                image: NetworkImage(
                    "https://thumbs.dreamstime.com/z/d-isometric-vector-concept-mobile-grocery-list-shopping-app-flat-181622871.jpg"),
                fit: BoxFit.cover),
          border: Border.all(
            
            color: Color.fromARGB(255, 221, 161, 71),
            width: 5.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(20),
           color:Color.fromARGB(255, 172, 220, 90).withOpacity(0.5),
        ),
        child: const Center (
         
        ),
               
              ),
              Container(
                
                margin: EdgeInsets.all(
                              5
                              ),width: 150,
              
            decoration: BoxDecoration(
                 image: DecorationImage(
                image: NetworkImage(
                    "https://barn2.com/wp-content/uploads/2018/03/Create-a-WooCommerce-Price-List-Blog-Header-820x369.png"),
                fit: BoxFit.cover),
          border: Border.all(
            color: Color.fromARGB(255, 221, 161, 71),
             width: 5.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(20),
           color:Color.fromARGB(255, 172, 220, 90).withOpacity(0.5),
        ),
        child: const Center (
         
        ),
              ),
              Container(
              
                margin: EdgeInsets.all(
                              5
                              ),width: 150,
                decoration: BoxDecoration(
                 image: DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz94eeo8JMzupDzTlwT0gQ41B9h-BCLUOZ4g&usqp=CAU"),
                fit: BoxFit.cover),
          border: Border.all(
            color: Color.fromARGB(255, 221, 161, 71),
            width: 5.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(20),
           color:Color.fromARGB(255, 172, 220, 90).withOpacity(0.5),
        ),
        child: const Center (
          child: Text('')
        ),
              ),
              Container(
                margin: EdgeInsets.all(
                              5
                              ),width: 150,
              decoration: BoxDecoration(
                 image: DecorationImage(
                image: NetworkImage(
                    "https://www.evolutionnutrition.com/sites/default/files/article-images/Online%20Grocery%20Inside.jpg"),
                fit: BoxFit.cover),
          border: Border.all(
            color:Color.fromARGB(255, 221, 161, 71),
            width: 5.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(20),
           color:Color.fromARGB(255, 172, 220, 90).withOpacity(0.5),
        ),
        child: const Center (
          child: Text('')
        ),
              ),
          
            ],
          ),
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

  