import 'package:untitled/models/product.dart';

class CartItem {
  final Product product;
  final int count;

  CartItem({
    required this.product,
    required this.count,
  });
}
