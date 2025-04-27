import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal:20),
                child: Row(children: [
                  Image.asset("assets/images/popmart.png",
                    height: 40,
                  ),
                  Stack(
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        size: 28,
                      ),
                      Positioned(child: Container())
                  ],)
                ],
                ),
            ),
          ],
        )
      ),
    );
  }
}