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
var sessionManager = SessionManager();

//UI USER INTERFACs
class first extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child:
            // ListView(
            //       children: <Widget>[  Image.asset(
            //         "assets/images/logo.png",
            //         height: 30,
            //         width: 30,

            //       ),
            Scaffold(
          appBar: AppBar(
            title: const Text(' '),
            backgroundColor: Colors.cyan[700],
            bottom: TabBar(
              indicatorColor: Colors.pink,
              indicatorWeight: 5,
              labelColor: Colors.pink,
              tabs: [
                Tab(
                  child: Text("Login as user"),
                  icon: Icon(Icons.login),
                ),
                Tab(
                  child: Text("Login as Admin"),
                  icon: Icon(Icons.admin_panel_settings),
                ),
                Tab(
                  child: Text("Register"),
                  icon: Icon(Icons.how_to_reg),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyStatefulWidget(),
              MyStatefulWidget1(),
              MyStatefulWidget2(),
            ],
          ),
        )
        // ]
        );
    // );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String name = "No Value Entered";
  String pass = "No Value Entered";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future login1(String n, String p) async {
    print(n);
    print(p);
    try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/login?username=' +
              n +
              '&&userpass=' +
              p),
          headers: {'Content-Type': 'application/json'});
      if (res.body.contains("@")) {
        // Map<String, dynamic> map = json.decode(res.body);
        // List<dynamic> data = map["result"];




        
        print("sucess");
        await sessionManager.set("namename", n);
        await sessionManager.set("passpass", p);
        Navigator.of(context).push(MaterialPageRoute(builder: (c) => homm()));

        return const homm();
      } else {
        print("failed1");
        AlertDialog alert = AlertDialog(
          content: Text("please try again"),
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e) {
      print("no login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            //     BackgroundImage(
            //   image: 'images/file.jpg',
            // ),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://blog.mostaql.com/wp-content/uploads/2020/11/%D8%A3%D8%B3%D8%A8%D8%A7%D8%A8-%D8%AA%D8%AE%D9%84%D9%8A-%D8%A7%D9%84%D9%85%D8%B4%D8%AA%D8%B1%D9%88%D9%86-%D8%B9%D9%86-%D8%B3%D9%84%D8%A9-%D8%A7%D9%84%D8%B4%D8%B1%D8%A7%D8%A1-1.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'User Name',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        onChanged: (value) => name = value,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[500]!.withOpacity(0.4),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.lock,
                            size: 28,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      onChanged: (value) => pass = value,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // Background color
                        // Text Color (Foreground color)
                      ),
                      onPressed: () async {
                        login1(name, pass);
                      },
                      child: Text("login"),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                  ),
                ])),
          ],
        ));
  }
}

// class BackgroundImage extends StatelessWidget {
//   const BackgroundImage({
//     Key? key,
//     required this.image,
//   }) : super(key: key);

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (rect) => LinearGradient(
//         begin: Alignment.bottomCenter,
//         end: Alignment.center,
//         colors: [Colors.black, Colors.transparent],
//       ).createShader(rect),
//       blendMode: BlendMode.darken,
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(image),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyStatefulWidget1 extends StatefulWidget {
  const MyStatefulWidget1({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget1> createState() => _MyStatefulWidgetState1();
}

class _MyStatefulWidgetState1 extends State<MyStatefulWidget1> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();

  String name1 = "No Value Entered";
  String pass1 = "No Value Entered";

  @override
  void initState() {
    super.initState();
  }

  Future loginadmin(String n, String p) async {
    print(n);
    print(p);
    try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/loginadmin?AdminName=' +
              n +
              '&&AdminPass=' +
              p),
          headers: {'Content-Type': 'application/json'});
      if (res.body.contains("@")) {
        // Map<String, dynamic> map = json.decode(res.body);
        // List<dynamic> data = map["result"];
        print("sucess");
      } else {
        print("failed");
        AlertDialog alert = AlertDialog(
          content: Text("please try again"),
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e) {
      print("no login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            //     BackgroundImage(
            //   image: 'images/file.jpg',
            // ),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAENGXsk5ISiszsV-9gZyxToXE1P1QnZd_oQ&usqp=CAU"),
                      fit: BoxFit.cover),
                ),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Admin Name',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        onChanged: (value) => name1 = value,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[500]!.withOpacity(0.4),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.lock,
                            size: 28,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      onChanged: (value) => pass1 = value,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink, // Background color
                          // Text Color (Foreground color)
                        ),
                        child: const Text('Login'),
                        onPressed: () {
                          print(name1);
                          loginadmin(name1, pass1);
                        },
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                  ),
                ])),
          ],
        ));
  }
}

class MyStatefulWidget2 extends StatefulWidget {
 
 const MyStatefulWidget2({super.key});

  @override
  State<MyStatefulWidget2> createState() => _MyStatefulWidgetState2();
}

class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> {
  TextEditingController nameController2 = TextEditingController();

  TextEditingController emailController2 = TextEditingController();
  TextEditingController placeController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();

  @override
  void dispose() {
    nameController2.dispose();
    emailController2.dispose();
    placeController2.dispose();
    passwordController2.dispose();
    phoneController2.dispose();

    super.dispose();
  }

  @override
  void initState() {
    
    super.initState();
  }

  void register(String name, String pass, String email, String place,
      String phone1) async {
    try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.1.65:3000/register?username=' +
              name +
              '&&userpass=' +
              pass +
              '&&place=' +
              place +
              '&&email=' +
              email +
              '&&phone=' +
              phone1),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("no register");
    }
  }
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
          children: <Widget>[
            //     BackgroundImage(
            //   image: 'images/file.jpg',
            // ),

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media.istockphoto.com/photos/female-customer-buying-coffee-and-placing-signature-on-tablet-picture-id1138022521?k=20&m=1138022521&s=612x612&w=0&h=64LbjGG21JIx6E5WgyXfUU0SEaVe62PbV_W40T5UGqE="),
                     
                      fit: BoxFit.cover),
                ),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: nameController2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Enter Your Name',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                       validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a name";
                              }
                              return null;
                            },

                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailController2,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                         
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Enter Your Email',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.email,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),   validator: (val) {
                              if((val!.isEmpty) || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },

                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: placeController2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'place',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.place,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a valid place";
                              }
                              return null;
                            },

                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: passwordController2,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[500]!.withOpacity(0.4),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.pink, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.lock,
                            size: 28,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a valid password";
                              }
                              return null;
                            }, ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: phoneController2,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.pink, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'phone',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.phone,
                              size: 28,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a valid phone";
                              }
                              return null;
                            }, ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink, // Background color
                          // Text Color (Foreground color)
                        ),
                        child: const Text('Register'),
                        onPressed: () {
                          
                            
                          // if (nameController2.text != '' &&
                          //     passwordController2.text != '' &&
                          //     emailController2.text != '' &&
                          //     placeController2.text != '')
                          // {
                              if (_formKey.currentState!.validate()) { register(
                                nameController2.text,
                                passwordController2.text,
                                emailController2.text,
                                placeController2.text,
                                phoneController2.text);
                                                             
ScaffoldMessenger.of(context).showSnackBar(
  
        const SnackBar(content: Text('Processing Data')),
      );
                                }
 
                          // }
                          // else {
                          //   AlertDialog alert = AlertDialog(
                          //     content: Text("please fill all feild"),
                          //   );
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return alert;
                          //     },
                          //   );
                          // }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                  ),
                ])),
          ],
        ));
  }
}
