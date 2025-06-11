import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import 'animated_check_icon.dart';

void showPaymentSuccessModal(BuildContext context, CartController cartController, Map params) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF45a049)]),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnimatedCheckIcon(),
              const SizedBox(height: 20),
              const Text('Payment Successful! 🎉', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Thank you for your purchase!\nYour order has been confirmed.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  cartController.clearCart();
                  Get.back(); // close modal
                  Get.offAllNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4CAF50),
                ),
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
