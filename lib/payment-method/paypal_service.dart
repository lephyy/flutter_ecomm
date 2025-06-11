import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';
import '../controllers/authentication.dart';
import '../controllers/cart_controller.dart';
import '../widgets/payment/payment_success_modal.dart';
import '../utils/cart_utils.dart';

class PaypalService {
  static void startPaypalCheckout(
      BuildContext context,
      double total,
      CartController cartController, {
        required String name,
        required String email,
        required String address,
        required String phone,
        required String city,
      }) {
    final subtotal = calculateCartSubtotal(cartController);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: "YOUR_CLIENT_ID",
          secretKey: "YOUR_SECRET_KEY",
          transactions: [_buildTransaction(cartController, subtotal)],
          note: "Contact us for any questions on your order.",
          onSuccess: (params) => _handleSuccess(context, params, cartController, {
            'name': name,
            'email': email,
            'address': address,
            'phone': phone,
            'city': city,
          }),
          onError: (error) {
            Get.snackbar("Payment Failed", error.toString(),
                backgroundColor: Colors.red, colorText: Colors.white);
          },
          onCancel: () {
            Get.snackbar("Payment Cancelled", "You cancelled the payment",
                backgroundColor: Colors.orange, colorText: Colors.white);
          },
        ),
      ),
    );
  }

  static Map<String, dynamic> _buildTransaction(CartController cartController, double subtotal) {
    return {
      "amount": {
        "total": subtotal.toStringAsFixed(2),
        "currency": "USD",
        "details": {
          "subtotal": subtotal.toStringAsFixed(2),
          "shipping": "0",
          "shipping_discount": "0"
        }
      },
      "description": "Payment for your order",
      "item_list": {
        "items": cartController.cartItems.map((item) {
          return {
            "name": item.name,
            "quantity": item.quantity.toString(),
            "price": item.price.toStringAsFixed(2),
            "currency": "USD"
          };
        }).toList()
      }
    };
  }

  static Future<void> _handleSuccess(BuildContext context, Map params, CartController cartController, Map<String, String> customerData) async {
    final isLoggedIn = await _checkUserLoginStatus();
    if (!isLoggedIn) {
      Get.snackbar("Authentication Required", "Please login to complete your order. Your payment was successful.",
          backgroundColor: Colors.orange, colorText: Colors.white);
      Get.offAllNamed('/signIn');
      return;
    }

    Get.dialog(const Center(child: CircularProgressIndicator(color: Colors.green)), barrierDismissible: false);

    try {
      await _saveOrderToBackend(params, cartController, customerData);
      Get.back(); // Close loading dialog
      showPaymentSuccessModal(context, cartController, params);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Payment successful but failed to save order. Please contact support.",
          backgroundColor: Colors.red, colorText: Colors.white);
      print("❌ Error saving order: $e");
    }
  }

  static Future<bool> _checkUserLoginStatus() async {
    try {
      final authController = AuthenticationController.instance;
      final token = await authController.getToken();
      return token != null && token.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _saveOrderToBackend(Map params, CartController cartController, Map<String, String> customerData) async {
    final token = await AuthenticationController.instance.getToken();
    if (token == null || token.isEmpty) throw Exception('Please login again.');

    var url = Uri.parse(kStorePaymentUrl);
    final subtotal = calculateCartSubtotal(cartController);
    final transactionId = params['id'] ?? '';
    final amount = double.tryParse(params['transactions']?[0]['amount']['total'] ?? '') ?? subtotal;

    final requestBody = {
      ...customerData,
      'total': amount,
      'subtotal': subtotal,
      'shipping': 0.0,
      'discount': 0.0,
      'payment_method': 'paypal',
      'transaction_id': transactionId,
      'cart': cartController.cartItems.map((item) => {
        'product_id': item.id,
        'title': item.name,
        'qty': item.quantity,
        'price': item.price,
      }).toList(),
    };

    final response = await http.post(url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save order: ${response.body}');
    }
  }
}