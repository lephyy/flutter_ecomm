import 'package:flutter/material.dart';
import 'package:flutter_ecomm/page/cart/shop_list_item_widget.dart';

import '../../models/shop_item.dart';

class ShoppingList extends StatelessWidget {
  final List<ShopItem> shopItems;
  final Function(ShopItem)? onItemDeleted;
  final Function(ShopItem, int)? onQuantityChanged;

  const ShoppingList({
    super.key,
    required this.shopItems,
    this.onItemDeleted,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          ...shopItems.map(
                (e) => ShopListItemWidget(
              shopItem: e,
              onItemDeleted: onItemDeleted,
              onQuantityChanged: (ShopItem item) {
                if (onQuantityChanged != null) {
                  onQuantityChanged!(item, item.quantity);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
