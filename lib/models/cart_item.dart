import 'package:untitled/models/product.dart';
enum Shade { orange, green }
class CartItem {
  final String username;
  final String listname;
  final int price;
factory CartItem.fromJson(Map<String,dynamic> json) => CartItem(
    username: json['username']   == null ? '' : json['username']as String,
    listname: json['listname']   == null ? '' : json['listname']as String,
    price: json['price'] == null ? 0 : json['price'] as int,
    
  );
  CartItem({
    required this.username,
    required this.listname,
    required this.price,
  });


   String getFormattedPrice() {
    return '\$$price';
  }




 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
     data['listname'] = this.listname;
    data['price'] = this.price;
    

    return data;
  }
}

