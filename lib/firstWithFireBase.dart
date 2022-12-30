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
import 'package:untitled/pages/chat.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:untitled/helper/appcolors.dart';
import 'package:untitled/widgets/myButton.dart';
import 'package:untitled/widgets/themebutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/pages/chat.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/pages/fetchdata.dart';
var sessionManager = SessionManager();

//UI USER INTERFACs
class firstWithFireBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
            backgroundColor: Color.fromARGB(255, 172, 190, 90),
            bottom: TabBar(
              indicatorColor: Color.fromARGB(255, 251, 250, 248),
              indicatorWeight: 5,
              labelColor: Color.fromARGB(255, 248, 247, 246),
              tabs: [
                Tab(
                  child: Text("Login"),
                  icon: Icon(Icons.login),
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
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

   TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  
  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }

 Future login1(String n, String p) async {
   fetchdata fetch=new fetchdata();
    try {
//await
var res=await fetch.login(n,p);
print(res);
      if (res.body.contains("@")) {
        // Map<String, dynamic> map = json.decode(res.body);
        // List<dynamic> data = map["result"];

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
                  color: Color.fromARGB(255, 53, 78, 67),
                  image: DecorationImage(
                    image: AssetImage('assets/images/of_main_bg.png'),
                    fit: BoxFit.fill,
                    opacity: 0.3,
                  ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: SizedBox(
                      child: TextFormField(
                         controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 202, 218, 131),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.DARK_GREEN, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.DARK_GREEN, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'User Name',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: AppColors.DARK_GREEN,
                            ),
                          ),
                        ),
                      onChanged: (value) {
                            email = value;
                            
                          },

                       validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a name";
                              }
                              return null;
                            },  ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: TextFormField(
                       controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style:
                          TextStyle(color: AppColors.DARK_GREEN, fontSize: 13),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 202, 218, 131),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 181, 207, 162),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.DARK_GREEN, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.lock,
                            size: 28,
                            color: AppColors.DARK_GREEN,
                          ),
                        ),
                      ),
                     onChanged: (value) {
                          password = value;
                          
                        },

                  validator: (val) {
                              if((val!.isEmpty) ){
                                return "Enter a pass";
                              }
                              return null;
                            },  ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 244, 242, 239)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                  ),
       
                        Container(
                      child: ThemeButton(
                    label: "Login",
                    labelColor: Color.fromARGB(255, 255, 255, 255),
                    color: Colors.transparent,
                    highlight:
                        Color.fromARGB(255, 172, 190, 90).withOpacity(0.5),
                    borderColor: Color.fromARGB(255, 172, 190, 90),
                    borderWidth: 4,
                    onClick: () async {
                      login1(nameController.text, passwordController.text);
                   setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return homm();
                            }));
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    )),






                  Row(
                    children: <Widget>[
                      const Text(
                        'Does not have account?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 252, 252, 251),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 21,
                            color: Color.fromARGB(255, 202, 218, 131),
                          ),
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
                    padding: const EdgeInsets.all(140),
                  ),
                ])),
          ],
        ));
  }
}

class MyStatefulWidget2 extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  const MyStatefulWidget2({super.key});

  @override
  State<MyStatefulWidget2> createState() => _MyStatefulWidgetState2();
}

class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> {
  final _auth = FirebaseAuth.instance;

  late String name;
  late String email;
  late String place;
  late String phone;
  late String password;
  bool showSpinner = false;

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
          Uri.parse(fetchdata.apiUrl +
              'register?username=' +
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Form(
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
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: 'Enter Your Name',
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.person,
                                size: 28,
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                            ),
                          ),

                          validator: (val) {
                            if ((val!.isEmpty)) {
                              return "Enter a name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[500]!.withOpacity(0.4),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: 'Enter Your Email',
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.email,
                                size: 28,
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                            ),
                          ),



                          validator: (val) {
                            if ((val!.isEmpty) ||
                                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(val)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
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
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 214, 152, 59)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: 'place',
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.place,
                                size: 28,
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                            ),
                          ),
                          
                          validator: (val) {
                            if ((val!.isEmpty)) {
                              return "Enter a valid place";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            place = value;
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[500]!.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 214, 152, 59)),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 214, 152, 59)),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Password',
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.lock,
                              size: 28,
                              color: Color.fromARGB(255, 214, 152, 59),
                            ),
                          ),
                        ),
                        validator: (val) {
                          if ((val!.isEmpty)) {
                            return "Enter a valid password";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: phoneController2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[500]!.withOpacity(0.4),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 214, 152, 59)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 214, 152, 59)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: 'phone',
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.phone,
                                size: 28,
                                color: Color.fromARGB(255, 214, 152, 59),
                              ),
                            ),
                          ),
                          validator: (val) {
                            if ((val!.isEmpty)) {
                              return "Enter a valid phone";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            phone = value;
                          },
                        ),
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
                            primary: Color.fromARGB(
                                255, 214, 152, 59), // Background color
                            // Text Color (Foreground color)
                          ),
                          child: const Text('Register'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              register(
                                  nameController2.text,
                                  passwordController2.text,
                                  emailController2.text,
                                  placeController2.text,
                                  phoneController2.text);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                            // print(email);
                            // print(password);
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return firstWithFireBase();
                              }));
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
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
          )),
    );
  }
}
