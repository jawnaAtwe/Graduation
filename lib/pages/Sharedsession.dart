

import 'package:untitled/pages/listitems.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';
import 'package:untitled/constants/constants.dart';
import 'dart:ui';
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

import 'package:untitled/pages/local_notification_service.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:highlight_text/highlight_text.dart';

class Sharedsession{

 savename(String A,String B) async{
final prefs = await SharedPreferences.getInstance();
 prefs.setString("namename", A);
 prefs.setString("passpass", B);

//  await sessionManager.set("namename", A);
//  await sessionManager.set("passpass", B);
}
 saveupdatelist(String A) async{
final prefs = await SharedPreferences.getInstance();
 prefs.setString("current-listup", A);

}
 savelist(String A,String B) async{
final prefs = await SharedPreferences.getInstance();
 prefs.setString("current-list", A);
 prefs.setString("current-price", B);
 
                    

}





}