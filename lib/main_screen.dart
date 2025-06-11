import 'package:flutter/material.dart';
import 'package:flutter_ecomm/page/cart/cart_screen.dart';
import 'package:flutter_ecomm/page/homepage/home_screen.dart';
import 'package:flutter_ecomm/page/products/all_product.dart';
import 'package:flutter_ecomm/page/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'controllers/cart_controller.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int selectedIndex = 0;

  final CartController cartController = Get.find<CartController>();

  final List pages = [
    const HomeScreen(),
    const AllProducts(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.shop),
            label: "Shop",
          ),

          // Here is the cart item with badge
          BottomNavigationBarItem(
            icon: Obx(() {
              int cartCount = cartController.itemCount;
              return Stack(
                children: [
                  const Icon(Iconsax.shopping_cart),
                  if (cartCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        // child: Text(
                        //   '$count',
                        //   style: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 12,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                      ),
                    ),
                ],
              );
            }),
            label: "Cart",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Iconsax.personalcard),
            label: "Profile",
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
