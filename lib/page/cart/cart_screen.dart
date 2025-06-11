import 'package:flutter/material.dart';
import 'package:flutter_ecomm/page/cart/shopping_cart.dart';
import '../../main_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: TColors.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeMain()),
            );
          },
        ),
      ),
      body: const Body(),
    );
  }
}