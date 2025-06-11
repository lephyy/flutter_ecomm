import 'package:flutter/material.dart';
import 'package:flutter_ecomm/models/shop_item.dart';
import 'package:flutter_ecomm/page/cart/shopping_cart_body.dart';
import 'package:flutter_ecomm/page/cart/shopping_cart_empty.dart';
import 'package:flutter_ecomm/page/cart/shopping_cart_header.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/cart_controller.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return SafeArea(
      child: Column(
        children: [
          // const ShoppingCartHeader(),
          Expanded(
            child: Obx(() => cartController.cartItems.isEmpty
                ? const ShoppingCartEmpty()
                : ShoppingCartBody(shopItems: cartController.cartItems)),
          ),
        ],
      ),
    );
  }
}
