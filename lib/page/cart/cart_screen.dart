import 'package:flutter/material.dart';
import 'package:flutter_ecomm/utils/app_styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/AppBar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          itemBuilder: (_, index) =>
            TCartItem(),
        ),
      ),
    );
  }
}

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Image.asset("assets/images/product1.png", width: 120, height: 110),
      SizedBox(width: 20),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child:Text("Product Name", style: poppinsBold),),
          const Flexible(child:Text("Product Description", style: poppinsRegular,maxLines: 1),),
          Flexible(child:Text("\$100", style: poppinsBold),),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: "Quantity: ", style: poppinsRegular),
              TextSpan(text: "1", style: poppinsBold),
            ],
          ))
        ],
      )
    ],
              );
  }
}
