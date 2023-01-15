import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
enum Shade { orange, green }

class offermodel {
  final String productname;
  final int newprice;
 
  final String offerratio;
  final String date;
  final String marketname;
  // final String expiryDate;
  // final int productNumber;
// final List<int> image;

  final bool inCart;
  final Shade shade;

  
factory offermodel.fromJson(Map<String,dynamic> json) => offermodel(
    productname: json['productname']  == null ? '' : json['productname']as String,
  newprice: json['newprice'] == null ? 0 : json['newprice']as int,
   
    
    offerratio: json['offer-ratio']  == null ? '' : json['offer-ratio']as String,
    date: json['date']  == null ? '' : json['date']as String,
   marketname: json['marketname']  == null ? '' : json['marketname']as String,
  );
  
  offermodel({
    required this.productname,
    required this.newprice,
  
    required this.offerratio,
    required this.date,
required this.marketname,
    this.inCart = false,
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
   data['newprice'] = this.newprice;
    
    data['offerratio'] = this.offerratio;
   data['date'] = this.date;
 data['marketname'] = this.marketname;
    return data;
  }

}
