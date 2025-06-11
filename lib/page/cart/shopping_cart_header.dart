import 'package:flutter/material.dart';
import 'package:flutter_ecomm/constants/fonts_string.dart';
import '../../constants/colors_string.dart';
import '../../constants/sizes_string.dart';

class ShoppingCartHeader extends StatelessWidget {
  const ShoppingCartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration:const BoxDecoration(
      //     border: Border(bottom: BorderSide(width:.5,color: TColors.primary))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Row(
          children: [
            Text(
                "Shopping Cart",
                style: TFonts.heading1,
            ),
          ],
        ),
      ),
    );
  }
}