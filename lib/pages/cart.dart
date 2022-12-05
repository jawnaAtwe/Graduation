
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/wish_list.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'package:path/path.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:no_context_navigation/no_context_navigation.dart';
var sessionManager = SessionManager();


  late  List<CartItem> myList1=[];
  list1( List<CartItem> g) async {
  String k=await SessionManager().get("namename") ;
    http.Response res = await http.get(Uri.parse('http://192.168.1.65:3000/showlist?username='+k),
  headers: {
'Content-Type':'application/json'

  }
       
 );
//     http.Response res = await http.get(Uri.parse('http://192.168.1.65:3000/showlist?username='+k ),
//           headers: {'Content-Type': 'application/json'}
       
//  );
print("kkkk");
  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
   

    var jsonString = json.decode(res.body);
    List<CartItem> list = List<CartItem>.from(jsonString.map((i) => CartItem.fromJson(i)));
// List<Product> products = jsonString.map((jsonMap) => Product.fromJson(jsonMap)).toList();
     myList1= list;  

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

  join1( String a,String b) async {
   
  String n=await SessionManager().get("namename") ;
     try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/reglist?username=' +
              n +
              '&&listname=' +
             a+
              '&&price='+b),
          headers: {'Content-Type': 'application/json'});
     print("register");} catch (e) {
      print("no register");
    }
}

  updateinfo( String a,String b) async {
   
  String username=await SessionManager().get("namename") ;
  String listname=await SessionManager().get("current-listup") ;
     try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/updatelist?username=' +
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
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Cart> {



    deleteitems(String listname) async {
   String A=await SessionManager().get("namename") ;
   

   try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/deletelistitems?listName=' +
              listname +
              '&&userName=' +
              A 
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }}
    delete(String listname) async {
   String A=await SessionManager().get("namename") ;
   

   try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/deletelist?listname=' +
              listname +
              '&&username=' +
              A 
              ),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no filld");
    }}

   List<Widget> itemsData = [];
  void getPostsData() {


 List<Widget> listItems = [];

     myList1.forEach((post) {
    listItems.add(Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color.fromARGB(255, 209, 224, 199),
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
                    post.listname,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
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
                ],
              ), Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                      ElevatedButton(
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: ()async {
                  await sessionManager.set("current-listup", post.listname);
                  openDialogeupdate();
                  controllerText11 = TextEditingController();
                  controllerText22 = TextEditingController();
                  
                 
              },
              ),  
                  ElevatedButton(
                child: Text('-delete'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  delete(post.listname);
                  deleteitems(post.listname);
              },
              ),  ],
              ), 
              ElevatedButton(
                child: Text('Add Products'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  openDialoge1( post.listname,  "\$ ${post.price}");
                },
              )
            ],
          ),
        )));
    }); 
    setState(() {
      itemsData = listItems;
    });
  }
  // final CategoriesScroller categoriesScroller = CategoriesScroller();
 TextEditingController controllerText1=TextEditingController();
 TextEditingController controllerText2=TextEditingController();
 TextEditingController controllerText11=TextEditingController();
 TextEditingController controllerText22=TextEditingController();

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
 

   @override
  void dispose() {
    controllerText1.dispose();
    controllerText2.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
list1(myList1);
 getPostsData();
    controller.addListener(() {
      double value = controller.offset / 125;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 30;
      });
    });
  }

   
  String dialogeValue = '';

 
     void openDialoge1(String s1, String s2){
  Future openDialoge2() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 209, 224, 199),
            title: Text('ADD ITEMS USING :'),
            //content: Text('ADD ITEMS USING :'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: ()async {
                    await sessionManager.set("current-list", s1);
                      await sessionManager.set("current-price", s2);
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WishList();
                  }));
                },
                child: Text("Search For Items"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WishList();
                  }));
                },
                child: Text("Scanning"),
              ),
            ],
          ));
          openDialoge2();
}
  Future openDialoge() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 209, 224, 199),
            title: Text('New List'),
            content: Container(
                height: 115,
                child: Column(
                  children: [
                    TextField(
                      autocorrect: true,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(hintText: 'Enter The List Name'),
                      controller: controllerText1,
                    ),
                    TextField(
                      autocorrect: true,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(hintText: 'Enter The Total Price'),
                      controller: controllerText2,
                    ),
                  ],
                )),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: () {
                   join1(controllerText1.text , controllerText2.text);
                  Navigator.of(context)
                      .pop(controllerText1.text + "-" + controllerText2.text);
                 

                 getPostsData();

                },  
                child: Text("Create"),
              ),
            ],
          ));

  Future openDialogeupdate() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 209, 224, 199),
            title: Text('New List'),
            content: Container(
                height: 115,
                child: Column(
                  children: [
                    TextField(
                      autocorrect: true,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(hintText: 'Enter The New Name'),
                      controller: controllerText11,
                    ),
                    TextField(
                      autocorrect: true,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(hintText: 'Enter The Total Price'),
                      controller: controllerText22,
                    ),
                  ],
                )),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 161, 71),
                ),
                onPressed: () {
             updateinfo(controllerText11.text , controllerText22.text);
                },  
                child: Text("update"),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {

    

    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Your Lists'),
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
      children: [
        Expanded(
            child: Container(
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: ElevatedButton(
                child: Text('+ New List'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 201, 141, 51),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  openDialoge();
                  controllerText1 = TextEditingController();
                  controllerText2 = TextEditingController();
                },
              )),
        )),
      ],
    );
  }
}