import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
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

   late  List<Product> myList=[];
   late String blob='';

    addadd(String productName,String marketName,String manufacturing, int price,int amount) async {

    final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("current-list").toString() ;
   String A=prefs.get("namename").toString() ;
try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'listelementselect?listname=' +
              A1+'&&username=' +A ),
          headers: {'Content-Type': 'application/json'});

             
          var data = "${res.body}";
         addadd1(data,productName,marketName,manufacturing,price,amount);


    } catch (e) {
      print("no filld");
    }
////
    }

    
    addadd1(String name,String productName,String marketName,String manufacturing, int price,int count) async {
        print(price.toInt());
      
        final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("current-list").toString() ;
   try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'listelement?userName=' +
              name +
              '&&listName=' +
              A1 +
              '&&productName=' +
              productName +
              '&&marketName=' +
              marketName +
              '&&manufacturing=' +
              manufacturing+
              '&&price=' +
              '${price}'+
               '&&amount=' +
              '${count}'
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }
    getnumber( marketName,count);
    getnumber1( productName,count);
    }

     getnumber1(String name,int count)async{


   try{ http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'getnumbersalesofproduct?productName=' +
              name +
              '&&sales=' +
              '${count}' 
              ),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
 print("lplplplp");
       var jsonString = json.decode(res.body)as List;
   int count1=jsonString.elementAt(0)['sales'];
    int A=count1+count;
     print(A);
    addadd3(name,A);
    
    }else { print("noo");}
     } catch (e) {
      print("no filld");
    }
    
    }
addadd3(String name,int count)async{
print("numberrr");
 try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'sales?productName=' +
              name +
              '&&sales=' +
              '${count}' 
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }
}
    getnumber(String marketName,int count)async{


   try{ http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'getnumbersales?AdminName=' +
              marketName +
              '&&NumberSales=' +
              '${count}' 
              ),
      headers: {'Content-Type': 'application/json'});


  if (res.statusCode == 200) {
 print("lplplplp");
       var jsonString = json.decode(res.body)as List;
   int count1=jsonString.elementAt(0)['NumberSales'];
    int A=count1+count;
     print(A);
    addadd2(marketName,A);
    
    }else { print("noo");}
     } catch (e) {
      print("no filld");
    }
    
    }
addadd2(String marketName,int count)async{
print("numberrr");
 try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'numbersales?AdminName=' +
              marketName +
              '&&NumberSales=' +
              '${count}' 
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }
}

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

// wish(List<Product> g) async {
//   http.Response res = await http.get(Uri.parse(fetchdata.apiUrl+'wish'),
//       headers: {'Content-Type': 'application/json'});

//   if (res.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.

//     var jsonString = json.decode(res.body);
//     List<Product> list =
//         List<Product>.from(jsonString.map((i) => Product.fromJson(i)));
// // List<Product> products = jsonString.map((jsonMap) => Product.fromJson(jsonMap)).toList();
//     myList = list;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WishList> {

 late final LocalNotificationService service;
 
  var OpenFile;
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
  myList=await fetch.wish();
 }  
void getlist1() async{
  
var jsonString=await fetch.getinfo11();

 var blob=jsonString.elementAt(0)['image'];
Uint8List image = Base64Codec().decode(blob);      // image is a Uint8List


 }

//  void getimg(String image) async{
//   Uint8List fileBytes = await http.readBytes(Uri.parse(image));

//  }
void add() {
    setState(() {
      if (count != 10) count=count+1;
    });
    print(count);
    
     getPostsData();
  }

void minus() {
    setState(() {
      if (count != 0) count=count-1;
    }); getPostsData();
  }

Uint8List convertBase64Image(String base64String) {
  print(base64String);
  return Base64Decoder().convert(base64String.split(',').last);

}
  void getPostsData() async{
//    var jsonString=await fetch.getinfo11();

//   blob=jsonString.elementAt(0)['image'];
// Uint8List image = Base64Decoder().convert(blob); 


    List<Widget> listItems = [];
      List<Product> A = [];
    if(myList.isEmpty)
myList=await fetch.wish();
// XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
   // urlImageBlob is the URL where our file is hosted.


// Display if are image. Image.memory(fileBytes);
    myList.forEach((post) async {
    
    // Uint8List image = Base64Codec().decode(post.image);
// Uint8List image = Uint8List.fromList(post.image.toBytes());
      listItems.add(Container(
          height: 220,
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
                      post.productName,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    
                     SizedBox(
                      width: 20,
                    ),ElevatedButton(
                      child: Text('Add'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Pressed');

                        // addadd( post.productName,post.marketName,post.manufacturing,"\$ ${post.price}");
                        update(post.productName,post.marketName,post.manufacturing,"\$ ${post.price*count}", post.price,count);
                        

                 

                      },
                    )

,
                    
                    
                    ]),
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
           
          children:<Widget>[
              FloatingActionButton.small(
                heroTag: Text("btn1"),
                                      onPressed: add,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 241, 241, 241),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('$count',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: Text("btn2"),
                                      onPressed: minus,
                                      child: Text('-',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              
                                              fontWeight: FontWeight.bold)),
                                      backgroundColor:
                                          Color.fromARGB(255, 241, 241, 241),
                                    ),  
                                    
                    // ElevatedButton(
                    //   child: Text('Add To Card'),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.teal,
                    //     onPrimary: Colors.white,
                    //     onSurface: Colors.grey,
                    //   ),
                    //   onPressed: () {
                    //     print('Pressed');

                    //     // addadd( post.productName,post.marketName,post.manufacturing,"\$ ${post.price}");
                    //     update(post.productName,post.marketName,post.manufacturing,"\$ ${post.price*count}", post.price,count);
                        

                 

                    //   },
                    // )

// ,
          ]),
                  ],
                ),
// final url = file.path;

    //  OpenFile.open(post.image),

  //               Image(
  //   image: NetworkImage(
  //     (post.image),
  //     scale: 4
  //   ),
  // )
   
               
             
          
      
               
    // Image.asset('C:/Users/MIX-IT/Desktop/paltel.jpg',width: 50,height: 50,),
  Image.asset(post.image,width: 100,height: 120,),


                // Image.file(File(post.image)),
                // new Image.memory(image)
         
      //   Image.memory(
      //   Uint8List.fromList(post.image!),
      //   height: 88,
      //   width: 88,
      //   fit: BoxFit.cover,
      // )    
// convertBase64Image(post.image) ==null? Container():Image.memory(
//         base64Decode(post.image),
//         height: 88,
//         width: 88,  
//         fit: BoxFit.cover,
//       )   
            //  Image.memory(Uint8List.fromList(post.image)),
            //  CircleAvatar(
            //   backgroundImage: post.image!=""
            //       ? MemoryImage(
            //        Base64Codec().decode(post.image),
            //         )
            //       : null,)
              ]
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
final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("current-list").toString() ;
   String A=prefs.get("namename").toString() ;
 
 try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'nowupdate?userName=' +
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
   update (String productName,String marketName,String manufacturing, String price,int p,int amount) async {
    print("up");
final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("current-list").toString() ;
   String A=prefs.get("namename").toString() ;
 try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'update?userName=' +
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
    addadd( productName,marketName,manufacturing,p*count,count);
                        
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

  