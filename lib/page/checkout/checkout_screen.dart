import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_screen.dart';
import '../../models/shop_item.dart';
import '../../constants/colors_string.dart';
import '../../constants/button_string.dart';
import '../../controllers/cart_controller.dart';
import '../../payment-method/paypal_service.dart'; // adjust path as needed

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.find<CartController>();
  final _formKey = GlobalKey<FormState>();

  // Customer information controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController(text: "No. 123, Street ABC, Phnom Penh");
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController(text: "Phnom Penh");

  String _selectedPaymentMethod = 'PayPal'; // Default to PayPal
  bool _showCustomerForm = false;

  @override
  void initState() {
    super.initState();
    // You can pre-fill some data if available from user profile
    _loadUserData();
  }

  void _loadUserData() {
    // If you have user data stored somewhere, load it here
    // Example:
    // final user = Get.find<UserController>().currentUser;
    // _nameController.text = user.name ?? '';
    // _emailController.text = user.email ?? '';
    // _phoneController.text = user.phone ?? '';
  }

  double calculateTotal() {
    return cartController.cartItems.fold(
      0,
          (sum, item) => sum + item.price * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        final cartItems = cartController.cartItems;
        final total = calculateTotal();

        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Order Summary ListView
                Expanded(
                  child: ListView(
                    children: [
                      // Cart Items
                      _buildOrderSummary(cartItems),

                      const SizedBox(height: 16),

                      // Customer Information Section
                      _buildCustomerInfoSection(),

                      const SizedBox(height: 16),

                      // Delivery Address
                      _buildAddressCard(),

                      const SizedBox(height: 16),

                      // Payment Method Selection
                      _buildPaymentMethodSelector(),

                      const SizedBox(height: 16),

                      // Payment Summary
                      _buildSummaryCard(total),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Place Order Button
                _buildPlaceOrderButton(total),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOrderSummary(List cartItems) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(cartItems.length, (index) {
              final item = cartItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        item.imageUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 20),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text("Qty: ${item.quantity}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Customer Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showCustomerForm = !_showCustomerForm;
                    });
                  },
                  child: Text(_showCustomerForm ? "Hide" : "Edit"),
                ),
              ],
            ),
            if (_showCustomerForm) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your name';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your phone number';
                  return null;
                },
              ),
            ] else ...[
              if (_nameController.text.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text("Name: ${_nameController.text}"),
                Text("Email: ${_emailController.text}"),
                Text("Phone: ${_phoneController.text}"),
              ] else ...[
                const SizedBox(height: 8),
                const Text(
                  "Please fill in your information before placing order",
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red),
        title: const Text("Delivery Address"),
        subtitle: Text(_addressController.text),
        trailing: TextButton(
          onPressed: () {
            _showAddressDialog();
          },
          child: const Text("Change"),
        ),
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Address"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Address"),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: "City"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    final methods = {
      'ABA': 'assets/images/profile/abalogo.jpg',
      'PayPal': 'assets/images/profile/paypal_logo.png',
    };

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...methods.entries.map((entry) {
              return RadioListTile<String>(
                value: entry.key,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
                title: Row(
                  children: [
                    Image.asset(
                      entry.value,
                      width: 40,
                      height: 30,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 40,
                          height: 30,
                          color: Colors.grey[300],
                          child: Center(child: Text(entry.key)),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(entry.key),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(double total) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSummaryRow("Subtotal", total),
            _buildSummaryRow("Shipping", 2.99),
            const Divider(),
            _buildSummaryRow("Total", total + 2.99, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(double total) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _handlePlaceOrder(total);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Place Order",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _handlePlaceOrder(double total) {
    // Validate customer information
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "Please fill in your customer information first",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      setState(() {
        _showCustomerForm = true;
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final totalWithShipping = total + 2.99;

    if (_selectedPaymentMethod == 'PayPal') {
      // Start PayPal payment process with customer information
      PaypalService.startPaypalCheckout(
        context,
        totalWithShipping,
        cartController,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        phone: _phoneController.text.trim(),
        city: _cityController.text.trim(),
      );
    } else if (_selectedPaymentMethod == 'ABA') {
      // TODO: Implement ABA payment
      Get.snackbar(
        "ABA Payment",
        "ABA payment not yet implemented",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Payment Error",
        "Please select a valid payment method",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}