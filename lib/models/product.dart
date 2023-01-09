import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
enum Shade { orange, green }

class Product {
  final String marketName;
  final String productName;
  // final int  quantity;
  final int price;
  final String manufacturing;
  // final String expiryDate;
  // final int productNumber;
// final List<int> image;
  final String? description;
  final bool inCart;
  final Shade shade;
final  String   image;
  
factory Product.fromJson(Map<String,dynamic> json) => Product(
    marketName: json['marketName']  == null ? '' : json['marketName']as String,
  productName: json['productName']  == null ? '' : json['productName']as String,
    // quantity: json['quantity']  == null ? 0 : json['quantity'] as int,
    price: json['price'] == null ? 0 : json['price'] as int,
    manufacturing: json['manufacturing']  == null ? '' : json['manufacturing']as String,
    //  image: json['image'] as List<int>?,
    // image: Uint8List.fromList((json['image'] as List)
    //          .map((e) => e as int).toList())
    // expiryDate: json['expiryDate']  == null ? '' : json['expiryDate']as String,
    // productNumber: json['productNumber']   == null ? 0 : json['productNumber'] as int,
    //  image : List<int>.from(json["image"]),
  //  image: json['image'] as Map<String,dynamic> ,
        image: json['image']  == null ? '' : json['image']as String,
  );
  
  Product({
    required this.marketName,
    required this.productName,
    // required this.quantity,
    required this.price,
    required this.manufacturing,

    required this.image,
    // required this.expiryDate,
    // required this.productNumber,
    this.description,
    this.inCart = false,
    this.shade = Shade.green,
  });

  String getFormattedPrice() {
    return '\$$price';
  }




 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketName'] = this.marketName;
     data['productName'] = this.productName;
    //  data['quantity'] = this.quantity;
    data['price'] = this.price;

data['manufacturing'] = this.manufacturing;

// data['image'] = this.image;
    // data['expiryDate'] = this.expiryDate;
    // data['productNumber'] = this.productNumber;

    return data;
  }

}
