import 'package:flutter/material.dart';
import 'package:flutter_ecomm/page/cart/shopping_list.dart';
import 'package:flutter_ecomm/page/cart/shopping_list_price.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../models/shop_item.dart';
class ShoppingCartBody extends StatefulWidget {
  const ShoppingCartBody({
    super.key,
    required this.shopItems,
  });

  final List<ShopItem> shopItems;

  @override
  State<ShoppingCartBody> createState() => _ShoppingCartBodyState();
}

class _ShoppingCartBodyState extends State<ShoppingCartBody> {
  // Since this widget is stateful but shopItems is final, we won't update it here.
  // Updates should be handled by the CartController and reflected through GetX's reactive system.

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Flexible(
      child: Column(
        children: [
          ShoppingList(
            shopItems: widget.shopItems,
            onItemDeleted: (ShopItem item) {
              cartController.removeFromCart(item);
            },
            onQuantityChanged: (ShopItem item, int newQuantity) {
              cartController.updateItemQuantity(item, newQuantity);
            },
          ),
          ShoppingListPrice()
        ],
      ),
    );
  }
}