import 'package:flutter/material.dart';
import 'package:flutter_ecomm/models/all_products_model.dart';
import 'package:flutter_ecomm/models/shop_item.dart'; // Add this import
import 'package:flutter_ecomm/controllers/cart_controller.dart'; // Add this import
import 'package:flutter_ecomm/utils/app_styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

import '../cart/cart_screen.dart';

class ProductDetail extends StatefulWidget {
  final AllProductsModel? productDetail;
  const ProductDetail({super.key, this.productDetail});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isFavorite = false;

  // Get the cart controller
  final CartController cartController = Get.find<CartController>();

  // Helper method to convert AllProductsModel to ShopItem
  ShopItem _convertToShopItem(AllProductsModel product) {
    return ShopItem(
      id: product.id,
      name: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      shortDescription: product.shortDescription,
      quantity: 1, // Default quantity when adding to cart
      // Add other required fields based on your ShopItem model
    );
  }

  // Helper method to get total cart item count
  int get totalCartCount {
    return cartController.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Helper method to get quantity of current product in cart
  int getCurrentProductQuantity(int productId) {
    final item = cartController.cartItems.firstWhereOrNull((item) => item.id == productId);
    return item?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final AllProductsModel? productArg = Get.arguments as AllProductsModel?;
    final AllProductsModel? routeArg = ModalRoute.of(context)?.settings.arguments as AllProductsModel?;

    final AllProductsModel productDetail = widget.productDetail ?? productArg ?? routeArg!;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor2,
        title: const Text("Product Detail"),
        actions: [
          // Use Obx to reactively update cart count
          Obx(() => Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () => Get.to(() => CartScreen() ),
                icon: Icon(Iconsax.shopping_bag, size: 28,),
              ),
              if (totalCartCount > 0)
                Positioned(
                  right: 5,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        totalCartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: backgroundColor2,
            height: size.height * 0.46,
            width: size.width,
            child: Center(
              child: Hero(
                tag: 'product_image_${productDetail.id}',
                child: productDetail.imageUrl.isNotEmpty
                    ? Image.network(
                  productDetail.imageUrl,
                  height: size.height * 0.4,
                  width: size.width * 0.85,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: size.height * 0.4,
                      width: size.width * 0.85,
                      color: Colors.grey[200],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                          Text('Image not available'),
                        ],
                      ),
                    );
                  },
                )
                    : Container(
                  height: size.height * 0.4,
                  width: size.width * 0.85,
                  color: Colors.grey[200],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 80, color: Colors.grey),
                      Text('No image available'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  productDetail.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // Price and Favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${productDetail.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.pink,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? '${productDetail.title} added to favorites'
                                  : '${productDetail.title} removed from favorites',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "${productDetail.shortDescription}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Show current quantity in cart for this product
                // Obx(() {
                //   final quantity = getCurrentProductQuantity(productDetail.id);
                //   if (quantity > 0) {
                //     return Container(
                //       padding: const EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //         color: Colors.green.withOpacity(0.1),
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(color: Colors.green),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               const Icon(Icons.check_circle, color: Colors.green, size: 20),
                //               const SizedBox(width: 8),
                //               Text(
                //                 '$quantity item${quantity > 1 ? 's' : ''} in cart',
                //                 style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //           // Quantity controls
                //           Row(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               GestureDetector(
                //                 onTap: () {
                //                   if (quantity > 1) {
                //                     final updatedItem = _convertToShopItem(productDetail);
                //                     cartController.updateItemQuantity(updatedItem, quantity - 1);
                //                   } else {
                //                     final itemToRemove = _convertToShopItem(productDetail);
                //                     cartController.removeFromCart(itemToRemove);
                //                   }
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.all(4),
                //                   decoration: BoxDecoration(
                //                     color: Colors.grey[200],
                //                     borderRadius: BorderRadius.circular(4),
                //                   ),
                //                   child: const Icon(Icons.remove, size: 16),
                //                 ),
                //               ),
                //               const SizedBox(width: 8),
                //               Text(
                //                 quantity.toString(),
                //                 style: const TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //               const SizedBox(width: 8),
                //               GestureDetector(
                //                 onTap: () {
                //                   final updatedItem = _convertToShopItem(productDetail);
                //                   cartController.updateItemQuantity(updatedItem, quantity + 1);
                //                 },
                //                 child: Container(
                //                   padding: const EdgeInsets.all(4),
                //                   decoration: BoxDecoration(
                //                     color: Colors.grey[200],
                //                     borderRadius: BorderRadius.circular(4),
                //                   ),
                //                   child: const Icon(Icons.add, size: 16),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     );
                //   }
                //   return const SizedBox.shrink();
                // }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Convert AllProductsModel to ShopItem and add to cart
                    final shopItem = _convertToShopItem(productDetail);
                    cartController.addToCart(shopItem);

                    // Show confirmation
                    Get.snackbar(
                      'Added to Cart',
                      '${productDetail.title} added to cart',
                      duration: const Duration(seconds: 1),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.shopping_bag, color: Colors.black),
                        SizedBox(width: 5),
                        Text("ADD TO CART", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Add to cart first, then proceed to checkout
                    final shopItem = _convertToShopItem(productDetail);
                    cartController.addToCart(shopItem);

                    // Navigate to checkout or show checkout dialog
                    Get.snackbar(
                      'Buy Now',
                      'Proceeding to checkout for ${productDetail.title}',
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    // You can navigate to checkout page here
                    // Get.toNamed('/checkout');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    color: Colors.black,
                    child: const Center(
                      child: Text("BUY NOW", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}