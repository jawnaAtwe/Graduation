import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/cart.dart';
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
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
TextEditingController productNameController = TextEditingController();
TextEditingController productImageURLController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productMarketController = TextEditingController();
TextEditingController productManufactureingController = TextEditingController();
   late  List<Product> myList=[];
    addadd(String productName,String marketName,String manufacturing ) async {
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
              manufacturing),
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
          .where((user) =>
              user.productName.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

 
      myList = results;
   
  }
   wish( List<Product> g) async {
  
          
    http.Response res = await http.get(Uri.parse('http://192.168.1.65:3000/wish'),
  headers: {
'Content-Type':'application/json'

  }
       
 );

  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
   

    var jsonString = json.decode(res.body);
    List<Product> list = List<Product>.from(jsonString.map((i) => Product.fromJson(i)));
// List<Product> products = jsonString.map((jsonMap) => Product.fromJson(jsonMap)).toList();
myList= list;

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
 
@override
  void initState() {
    
    super.initState();
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
                    ElevatedButton(
                      child: Text('Add To Card'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Pressed');
                        addadd( post.productName,post.marketName,post.manufacturing);
                      },
                    )
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
}

_buildSearchBar() {
  return Row(
    children: [
      Image.asset('assets/icons/delivery.png'),
      const SizedBox(
        width: kDefaultPadding,
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
          child: 
          TextField(onChanged: (value) => _runFilter(value),

            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Product',
                hintStyle: TextStyle(
                  color: const Color(0xff434040).withOpacity(0.30),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: const Color(0xff707070).withOpacity(0.30),
                )),
          ),
        ),


      )),
    ],
  );
  
}

