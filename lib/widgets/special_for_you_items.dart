import 'package:flutter/material.dart';
import 'package:flutter_ecomm/utils/app_styles.dart';
import '../controllers/cart_controller.dart';
import '../models/all_products_model.dart';
import 'package:get/get.dart';
import '../models/shop_item.dart';

class SpecialItems extends StatefulWidget {
  final AllProductsModel productItems;
  final Size size;

  const SpecialItems({
    super.key,
    required this.productItems,
    required this.size,
  });

  @override
  State<SpecialItems> createState() => _SpecialItemsState();
}

class _SpecialItemsState extends State<SpecialItems> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: '${widget.productItems.title}_${widget.productItems.imageUrl}',
          child: Stack(
            children: [
              Container(
                height: widget.size.height * 0.25,
                width: widget.size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: backgroundColor2,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.productItems.imageUrl),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black26,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black26,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        onPressed: () {
                          final cartController = Get.find<CartController>();
                          cartController.addToCart(
                            ShopItem(
                              id: widget.productItems.id,
                              name: widget.productItems.title,
                              price: widget.productItems.price,
                              imageUrl: widget.productItems.imageUrl,
                            ),
                          );

                          // Optional: Show snackbar for confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${widget.productItems.title} added to cart'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: widget.size.width * 0.5,
          child: Text(
            widget.productItems.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "\$${widget.productItems.price}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.pink,
                height: 1.5,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.star, color: Colors.amber, size: 17),
            const Text('4.5'),
            const Text("(120)", style: TextStyle(color: Colors.black26)),
          ],
        ),
      ],
    );
  }
}
