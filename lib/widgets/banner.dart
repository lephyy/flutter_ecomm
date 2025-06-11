import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants/sizes_string.dart';

class MyBanner extends StatefulWidget {
  const MyBanner({super.key});

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  int _currentIndex = 0;

  // List of banner images
  final List<String> bannerImages = [
    "assets/images/banners/banner2.jpg",
    "assets/images/banners/banner.png",
    "assets/images/banners/banner2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen size
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 8),
      child: Column(
        children: [
          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 200,  // Fixed height for banner
              viewportFraction: 0.92,  // Slightly less than full width for better appearance
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: bannerImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return TImage(
                    size: size,
                    imagePath: imagePath,
                    onPressed: () {
                      // Add action when banner is tapped
                      print('Banner tapped: $imagePath');
                    },
                  );
                },
              );
            }).toList(),
          ),

          // Carousel indicator
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TImage extends StatelessWidget {
  const TImage({
    super.key,
    required this.size,
    required this.imagePath,
    this.onPressed,
  });

  final Size size;
  final String imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}