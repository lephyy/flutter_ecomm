import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/button_string.dart';
import '../../constants/colors_string.dart';
import '../../controllers/cart_controller.dart';
import '../checkout/checkout_screen.dart';

class ShoppingListPrice extends StatelessWidget {
  const ShoppingListPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(() {
      double shippingFee = 2.99;

      double subTotal = cartController.cartItems.fold(
        0.0,
            (sum, item) => sum + (item.price * item.quantity),
      );

      double grandTotal = subTotal + shippingFee;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            buildPriceRow("Shipping Fee", shippingFee),
            const SizedBox(height: 5),
            buildPriceRow("Sub Total", subTotal),
            const SizedBox(height: 5),
            buildPriceRow("Grand Total", grandTotal, isBold: true),
            const SizedBox(height: 15),
            buildCheckoutButton(),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }

  Widget buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: TColors.dark.withOpacity(isBold ? 0.9 : 0.8),
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: TColors.dark.withOpacity(isBold ? 0.9 : 0.8),
          ),
        ),
      ],
    );
  }

  Widget buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        onPressed: () {
          Get.to(() => CheckoutScreen());
        },
        text: 'CHECKOUT',
      ),
    );
  }
}
