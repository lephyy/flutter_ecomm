import 'package:flutter/material.dart';
import 'package:flutter_ecomm/utils/app_styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/AppBar.dart';
import 'cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",style: poppinsBold,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) => Column(
            children: [
              const TCartItem(

              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(onPressed: onPressed, icon: const Icon(Iconsax.minus))
                ],
              ),
            ],
          )


        ),
      ),
    );
  }
}