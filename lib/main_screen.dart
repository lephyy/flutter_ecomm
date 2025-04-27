import 'package:flutter/material.dart';
import 'package:flutter_ecomm/page/homepage/home_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int selectedIndex = 0;
  final List pages = [
    const HomeScreen(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
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
        onTap: (value){
          setState(() {

          });
          selectedIndex = value;
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home),label: "Home",),
          BottomNavigationBarItem(icon: Icon(Iconsax.shop),label: "Shop",),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart),label: "Cart",),
          BottomNavigationBarItem(icon: Icon(Iconsax.personalcard),label: "Profile",),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
