enum Shade { orange, green }

class Product1 {
  final String marketName;
  final String productName;
 
  final int price;
   final int  amount;
  final String manufacturing;
  final String image;
  // final int productNumber;

  final String? description;
  final bool inCart;
  final Shade shade;
  
factory Product1.fromJson(Map<String,dynamic> json) => Product1(
    marketName: json['marketName']  == null ? '' : json['marketName']as String,
  productName: json['productName']  == null ? '' : json['productName']as String,
    amount: json['amount']  == null ? 0 : json['amount'] as int,
    price: json['price'] == null ? 0 : json['price'] as int,
    manufacturing: json['manufacturing']  == null ? '' : json['manufacturing']as String,
    image: json['image']  == null ? '' : json['image']as String,
    // productNumber: json['productNumber']   == null ? 0 : json['productNumber'] as int,
  );
  
  Product1({
    required this.marketName,
    required this.productName,
    required this.amount,
    required this.price,
    required this.manufacturing,
    required this.image,
    // required this.productNumber,
    this.description,
    this.inCart = false,
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketName'] = this.marketName;
     data['productName'] = this.productName;
     data['amount'] = this.amount;
    data['price'] = this.price;

data['manufacturing'] = this.manufacturing;
    data['image'] = this.image;
    // data['productNumber'] = this.productNumber;

    return data;
  }

}
