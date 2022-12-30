import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:untitled/homm.dart';
import 'package:untitled/pages/getCurrentLocation.dart';

import 'package:http/http.dart' as http;

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:any_animated_button/any_animated_button.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:untitled/widgets/iconfont.dart';
import 'package:untitled/helper/iconhelper.dart';
import 'package:untitled/helper/appcolors.dart';
import 'package:untitled/widgets/themebutton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/firstWithFireBase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String istapped = '';

  //  final imageList = [
  //   'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
  //   'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  // ];
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 53, 78, 67),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/images/of_main_bg.png',
                        fit: BoxFit.cover),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ClipOval(
                          child: Container(
                            width: 180,
                            height: 180,
                            color: Color.fromARGB(255, 172, 190, 90),
                            alignment: Alignment.center,
                            child: ScaleTransition(
                              scale: _animation,
                              alignment: Alignment.center,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/logo.png",
                                        height: 160, width: 160),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text('Appetizing',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Text('Fun of shopping.\nAs many lists',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 40),
                      ThemeButton(
                        label: 'Map',
                        highlight: Colors.green[900],
                        color: Color.fromARGB(255, 172, 190, 90),
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MapScreen();
                          }));
                        },
                      ),
                      ThemeButton(
                        label: 'Home',
                        highlight: Colors.green[900],
                        color: AppColors.DARK_GREEN,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return firstWithFireBase();
                          }));
                        },
                      ),
                      ThemeButton(
                        label: "Test",
                        labelColor: Color.fromARGB(255, 255, 255, 255),
                        color: Colors.transparent,
                        highlight:
                            Color.fromARGB(255, 172, 190, 90).withOpacity(0.5),
                        borderColor: Color.fromARGB(255, 172, 190, 90),
                        borderWidth: 4,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return homm();
                          }));
                        },
                      )
                    ],
                  ),
                )
              ],
            )));
    // return Container(
    //   child: Scaffold(
    //       body: new Center(
    //           child:
    //               new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //     new Column(mainAxisAlignment: MainAxisAlignment.center, children: <
    //         Widget>[
    //       ScaleTransition(
    //         scale: _animation,
    //         alignment: Alignment.center,
    //         child: Center(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Image.asset("assets/images/logo.png",
    //                   height: 300, width: 300),
    //             ],
    //           ),
    //         ),
    //       ),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           primary: Colors.pink, // Background color
    //           // Text Color (Foreground color)
    //         ),
    //         onPressed: () {
    //           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //             return homm();
    //           }));
    //         },
    //         child: Text("map1"),
    //       ),
    //       Container(
    //         alignment: Alignment.center,
    //         padding: const EdgeInsets.all(10),
    //       ),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           primary: Colors.pink // Background color
    //           // Text Color (Foreground color)
    //         ),
    //         onPressed: () {
    //           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //             return first();
    //           }));
    //         },
    //         child: Text("user"),
    //       )
    //     ]),
    //   ]))),
    // );

    // new Swiper(
    //     itemBuilder: (BuildContext context,int index){
    //       return Image.network(
    //               imageList[index],
    //               fit: BoxFit.cover,
    //             );
    //     },
    //     itemCount: 3,
    //     pagination: new SwiperPagination(),
    //     control: new SwiperControl(),
    //   ),    );
  }
}