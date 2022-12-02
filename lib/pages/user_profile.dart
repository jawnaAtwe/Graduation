import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/pages/listitems.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/pages/profile.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: 'You',
        body: ListView(children: [
          _buildListItem('list', 'My Orders', () => {Navigator.of(context).push(MaterialPageRoute(builder: (c) => listitems()))}),
          _buildListItem('wish_list', 'My Favorite', () => {}),
          _buildListItem('wallet', 'Payment Details', () => {}),
          _buildListItem('settings', 'My Account', () =>{  Navigator.of(context).push(MaterialPageRoute(builder: (c) => pro()))}),
          
          // Navigator.of(context).push(MaterialPageRoute(builder: (c) => homm()));

    
        ]));
        
  }

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

