enum Shade { orange, green }

class Product1 {
  final String marketName;
  final String productName;
  // final int  quantity;
  // final int price;
  final String manufacturing;
  // final String expiryDate;
  // final int productNumber;

  final String? description;
  final bool inCart;
  final Shade shade;
  
factory Product1.fromJson(Map<String,dynamic> json) => Product1(
    marketName: json['marketName']  == null ? '' : json['marketName']as String,
  productName: json['productName']  == null ? '' : json['productName']as String,
    // quantity: json['quantity']  == null ? 0 : json['quantity'] as int,
    // price: json['price'] == null ? 0 : json['price'] as int,
    manufacturing: json['manufacturing']  == null ? '' : json['manufacturing']as String,
    // expiryDate: json['expiryDate']  == null ? '' : json['expiryDate']as String,
    // productNumber: json['productNumber']   == null ? 0 : json['productNumber'] as int,
  );
  
  Product1({
    required this.marketName,
    required this.productName,
    // required this.quantity,
    // required this.price,
    required this.manufacturing,
    // required this.expiryDate,
    // required this.productNumber,
    this.description,
    this.inCart = false,
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketName'] = this.marketName;
     data['productName'] = this.productName;
    //  data['quantity'] = this.quantity;
    // data['price'] = this.price;

data['manufacturing'] = this.manufacturing;
    // data['expiryDate'] = this.expiryDate;
    // data['productNumber'] = this.productNumber;

    return data;
  }

}
