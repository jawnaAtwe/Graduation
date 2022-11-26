import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
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



   late  List<Product> myList=[];


    addadd(String productName,String marketName,String manufacturing, String price) async {
   String A=await SessionManager().get("namename") ;
   String A1=await SessionManager().get("current-list") ;

   try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/listelement?userName=' +
              A +
              '&&listName=' +
              A1 +
              '&&productName=' +
              productName +
              '&&marketName=' +
              marketName +
              '&&manufacturing=' +
              manufacturing+
              '&&price=' +
              price
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }}


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
    // we use the toLowerCase() method to make it case-insensitive
  }

  myList = results;
}

wish(List<Product> g) async {
  http.Response res = await http.get(Uri.parse('http://192.168.1.65:3000/wish'),
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
  }
}

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WishList> {

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

  void initState() {
    super.initState();

    service = LocalNotificationService();
    service.intialize();
 

    _speechToText = stts.SpeechToText();
    _textEditingController.text = text;


    wish(myList);
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 125;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 30;
      });
    });
  }

  // final CategoriesScroller categoriesScroller = CategoriesScroller();
  // final List<Product> myList = [
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'broccoli',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'broccoli',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo'),
  //   Product(
  //       name: 'Deshi Mango',
  //       imageUrl: 'mango',
  //       price: 300,
  //       quantity: '1Kg',
  //       manufactureing: 'pravo',
  //       market: 'pravo')
  // ];

  ScrollController controller = ScrollController();

  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];

  void getPostsData() {
    List<Widget> listItems = [];
    // future: wish(myList);
    myList.forEach((post) {
      listItems.add(Container(
          height: 190,
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
                    Text(
                      post.productName,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.marketName,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      post.manufacturing,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "\$ ${post.price}",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           
          children:<Widget>[    ElevatedButton(
                      child: Text('Add To Card'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Pressed');

                        // addadd( post.productName,post.marketName,post.manufacturing,"\$ ${post.price}");
                        update(post.productName,post.marketName,post.manufacturing,"\$ ${post.price}");
                        

                 

                      },
                    )

,
          ]),
                  ],
                ),
                // Image.asset(
                //   "assets/images/${post.imageUrl}.png",
                //   height: double.infinity,
                // )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  show () async {
     try {
 await service.showNotificationWithPayload(
                          id: 0,
                          title: 'hi',
                          body: 'u can not add this product because u have not enough mony',
                          payload: '');
 } catch (e) {
      print("no filld");
    }
  }
 nowupdate (String price) async {

   String A=await SessionManager().get("namename") ;
   String A1=await SessionManager().get("current-list") ;
 try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/nowupdate?userName=' +
              A +
              '&&listName=' +
              A1+
              '&&price=' +
              price
              ),
          headers: {'Content-Type': 'application/json'});
       
       

            
    } catch (e) {
      print("no filld");
    }
 }
   update (String productName,String marketName,String manufacturing, String price) async {
    print("up");
String A=await SessionManager().get("namename") ;
   String A1=await SessionManager().get("current-list") ;
 try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/update?userName=' +
              A +
              '&&listName=' +
              A1+
              '&&price=' +
              price
              ),
          headers: {'Content-Type': 'application/json'});
       
          var data = "${res.body}";
          var zero = "0";
  if ("$data".compareTo("$zero").isNegative){ //compare
    show();
         print("nondone");
   
      } else {
        
    nowupdate("$data");
    addadd( productName,marketName,manufacturing,"\$ ${price}");
                        
       print("done");
      }

            
    } catch (e) {
      print("no filld");
    }

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
              onChanged: (value) => _runFilter(value),
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

// _buildSearchBar() {
//   return Row(
//     children: [
//       Image.asset('assets/icons/delivery.png'),
//       const SizedBox(
//         width: kDefaultPadding,
//       ),
//       Expanded(
//           child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 30,
//                   offset: const Offset(0, 5)),
//             ]),

            
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, top: 4),
//           child: 
//           TextField(onChanged: (value) => _runFilter(value),

//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search Product',
//                 hintStyle: TextStyle(
//                   color: const Color(0xff434040).withOpacity(0.30),
//                 ),
//                 suffixIcon: Icon(
//                   Icons.search,
//                   color: const Color(0xff707070).withOpacity(0.30),
//                 )),
//           ),
//         ),





//       )),
//     ],
//   );
  
// }

  