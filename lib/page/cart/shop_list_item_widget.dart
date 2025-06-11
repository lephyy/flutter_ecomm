import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/colors_string.dart';
import '../../controllers/cart_controller.dart';
import '../../models/shop_item.dart';

class ShopListItemWidget extends StatefulWidget {
  final ShopItem shopItem;
  final Function(ShopItem)? onQuantityChanged; // Callback for quantity changes
  final Function(ShopItem)? onItemDeleted;     // Callback for item deletion

  const ShopListItemWidget({
    super.key,
    required this.shopItem,
    this.onQuantityChanged,
    this.onItemDeleted,
  });

  @override
  State<ShopListItemWidget> createState() => _ShopListItemWidgetState();
}

class _ShopListItemWidgetState extends State<ShopListItemWidget> {
  int get quantity => widget.shopItem.quantity;

  void _updateQuantity(int newQuantity) {
    if (newQuantity >= 1) {
      setState(() {
        widget.shopItem.quantity = newQuantity;
      });

      final cartController = Get.find<CartController>();
      cartController.updateItemQuantity(widget.shopItem, newQuantity);
    }
  }

  void _deleteItem() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: Text('Are you sure you want to remove "${widget.shopItem.name}" from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.onItemDeleted != null) {
                  widget.onItemDeleted!(widget.shopItem);
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          buildImage(),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: TColors.grey,
                        width: .5,
                      )
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildNameLabel()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildPrice(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        widget.shopItem.imageUrl,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget buildDeleteButton() {
    return GestureDetector(
      onTap: _deleteItem,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }

  Widget buildNameLabel() {
    return Text(
      widget.shopItem.name,
      style: const TextStyle(fontSize: 16),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "\$${widget.shopItem.price.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        buildDeleteButton(),
        buildQtyControls(),
      ],
    );
  }

  Widget buildQtyControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildQtyControl(
          icon: Icons.remove,
          onTap: () => _updateQuantity(quantity - 1),
          isEnabled: quantity > 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            constraints: const BoxConstraints(minWidth: 30),
            child: Text(
              "$quantity",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        buildQtyControl(
          icon: Icons.add,
          onTap: () => _updateQuantity(quantity + 1),
          isEnabled: true,
        ),
      ],
    );
  }

  Widget buildQtyControl({
    required IconData icon,
    required Function() onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isEnabled ? TColors.dark : TColors.grey.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isEnabled ? TColors.light : TColors.grey,
          size: 16,
        ),
      ),
    );
  }
}