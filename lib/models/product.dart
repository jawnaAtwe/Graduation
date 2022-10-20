enum Shade { orange, green }

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String quantity;
  final String market;
  final String manufactureing;
  final String? description;
  final bool inCart;
  final Shade shade;
factory Product.fromJson(Map<String,dynamic> json) => Product(
    name: json['name']  == null ? '' : json['name']as String,
    imageUrl: json['imageUrl']  == null ? '' : json['imageUrl'] as String,
    price: json['price'] == null ? 0 : json['price'] as double,
    quantity: json['quantity']  == null ? '' : json['quantity']as String,
    market: json['market']  == null ? '' : json['market']as String,
    manufactureing: json['manufactureing']  == null ? '' : json['manufactureing']as String,
  );
  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.market,
    required this.manufactureing,
    this.description,
    this.inCart = false,
    this.shade = Shade.green,
  });

  String getFormattedPrice() {
    return '\$$price';
  }






}
