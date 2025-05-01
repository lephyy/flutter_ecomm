import 'package:flutter/material.dart';
import 'package:flutter_ecomm/models/category_model.dart';
import 'package:flutter_ecomm/page/catgory.dart';
import 'package:flutter_ecomm/utils/app_styles.dart';
import 'package:flutter_ecomm/widgets/curated_items.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../models/model.dart';
import '../../widgets/banner.dart';
import '../details/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            //Header parts
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/popmart.png",
                    height: 40,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        size: 28,
                      ),
                      //We make it dynamic during backend part
                      Positioned(
                        right: -3,top: -5,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //For banner
            const MyBanner(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shop by Category",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),

            //For Category
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(category.length, (index)=>InkWell(
                  onTap: (){
                    //Filter products based on the selected category
                    final filterItems = ProductCurated
                      .where((item)=>
                        item.category.toLowerCase() ==
                        category[index].name.toLowerCase())
                      .toList();
                    //Navigate to the categoryItems screen with filtered list
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=>CategoryItems(
                          category: category[index].name,
                          categoryItems: filterItems,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: backgroundColor1,
                          backgroundImage: AssetImage(category[index].image),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(category[index].name),
                    ],
                  ),
                )),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Curated For You",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            //For Curated Items
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: 
                List.generate(
                  ProductCurated.length,
                  (index){
                    final productItems = ProductCurated[index];
                    return Padding(padding: index == 0
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetail(productDetail:productItems),),);
                        },
                        child: CuratedItems(
                          productItems: productItems,
                          size: size,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}