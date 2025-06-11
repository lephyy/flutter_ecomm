import 'package:flutter/material.dart';

import '../../constants/button_string.dart';
import '../../constants/colors_string.dart';
import '../../utils/app_styles.dart';
import '../products/all_product.dart';

class ShoppingCartEmpty extends StatelessWidget {
  const ShoppingCartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImage(),
              const SizedBox(height: 30,),
              Text(
                "Your cart is empty",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary.withValues(alpha: 0.6)
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Explore our products and add some items to start shopping!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              buildGoShoppingButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Image.asset(
        "assets/images/profile/shopping_cart.png",
        height: 350,
      ),
    );
  }
  }
  Widget buildGoShoppingButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: "Shop Now",
        onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AllProducts()),
          );
        },
      ),
    );
  }
