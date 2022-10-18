import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/widgets/app_button.dart';
import 'package:untitled/widgets/base_view.dart';
import 'package:untitled/widgets/cart_product_item.dart';

TextEditingController totalPrice = new TextEditingController();
var price = 10.0;

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartItem> cart = [
      CartItem(
        product: Product(
          name: 'Pineapple',
          imageUrl: 'pineapple',
          price: 50,
          quantity: '4 in 1 pack',
          description: 'Pineapple',
          manufactureing: '',
          market: '',
        ),
        count: 1,
      ),
      CartItem(
        product: Product(
          name: 'Deshi Cabbage',
          imageUrl: 'cabbage',
          price: 90,
          quantity: '1kg',
          manufactureing: '',
          market: '',
          description: 'Pineapple',
        ),
        count: 4,
      ),
    ];
    return BaseView(
        title: 'Your Cart',
        useDefaultPadding: false,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: ListView(
                  children: [
                    for (CartItem cartItem in cart)
                      CartProductItem(cartItem: cartItem)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 53,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.elliptical(250, 70),
                ),
              ),
              child: Column(
                children: [
                  _buildToralPrice('Budget'),
                  _buildDetailItem('Total price', price, highlight: true),
                  _buildDetailItem(
                      'Remain', double.parse(totalPrice.text) - price),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        child: Row(
                          children: const [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Back to continue shooping',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '\$500.0',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  _buildDetailItem(String title, double amount, {bool highlight = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff434040),
                fontSize: 12,
              ),
            ),
            Text(
              '\$$amount',
              style: TextStyle(
                color: highlight ? const Color(0xffFC5455) : kTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Divider(
          color: const Color(0xff707070).withOpacity(0.30),
        )
      ],
    );
  }

  _buildToralPrice(String title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff434040),
                fontSize: 12,
              ),
            ),
            TextField(
                controller: totalPrice,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Total Price',
                  hintStyle: TextStyle(
                    color: Color(0xff434040),
                    fontSize: 12,
                  ),
                )),
          ],
        ),
        Divider(
          color: const Color(0xff707070).withOpacity(0.30),
        )
      ],
    );
  }
}
