import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/pages/Sharedsession.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/listitems.dart';
import 'package:untitled/pages/users.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/pages/profile.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: 'You',
        body: ListView(children: [
          _buildListItem(
              'list',
              'My Orders',
              () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => listitems()))
                  }),
          _buildListItem(
              'wish_list',
              'users',
              () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => users()))
                  }),

          _buildListItem(
              'settings',
              'My Account',
              () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => pro()))
                  }),
          _buildListItem(
              'settings',
              'Sign Out',
              () => {
                    logout(),
                    
                    _auth.signOut(),
                  
                   Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MyApp();
                    }))
                  }),

          // Navigator.of(context).push(MaterialPageRoute(builder: (c) => homm()));
        ]));
  }

  _buildListItem(String iconName, String title, Function() onPressed) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/icons/$iconName.svg',
        color: kPrimaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onPressed,
    );
  }
  void logout()async{
      Sharedsession shared=new Sharedsession();
      await shared.delete();
  }
}
