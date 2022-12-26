import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/pages/chat.dart';
import 'package:untitled/pages/getCurrentLocation.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/mapPage.dart';
import 'package:untitled/pages/user_profile.dart';
import 'package:untitled/pages/wish_list.dart';

class homm extends StatelessWidget {
  const homm({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Freebie',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: const Color(0xffffffff)),
      home: const MyHomePage1(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);
  @override
  State<MyHomePage1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: _buildPageContent(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: kBarIconColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _createBarIcon('home', 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _createBarIcon('wish_list', 1),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: _createBarIcon('cart', 2),
              label: 'Shopping',
            ),
            BottomNavigationBarItem(
              icon: _createBarIcon('user_profile', 3),
              label: 'You',
            ),
            BottomNavigationBarItem(
              icon: _createBarIcon('wallet', 4),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const Cart();
      case 2:
        return const WishList();
      case 3:
        return const UserProfile();
      case 4:
        return ChatScreen();
      default:
        return const Home();
    }
  }

  Widget _createBarIcon(String name, int index) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      color: _currentIndex == index
          ? Theme.of(context).primaryColor
          : kBarIconColor,
    );
  }
}
