import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/all_products_model.dart';
import '../../widgets/special_for_you_items.dart';
import '../constants/constants.dart';
import '../page/details/detail_screen.dart';

class BuildSpecialProducts extends StatefulWidget {
  const BuildSpecialProducts({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<BuildSpecialProducts> createState() => _BuildSpecialProductsState();
}

class _BuildSpecialProductsState extends State<BuildSpecialProducts> {
  List<AllProductsModel> allProductList = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> _fetchProducts() async {
    try {
      var url = Uri.parse(kProductUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> products = jsonData['data'];

        setState(() {
          allProductList = products
              .map((item) => AllProductsModel.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          allProductList.length,
              (index) {
            final productItem = allProductList[index];

            return Padding(
              padding: index == 0
                  ? const EdgeInsets.symmetric(horizontal: 20)
                  : const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetail(productDetail: productItem),
                    ),
                  );
                },
                child: SpecialItems(
                  productItems: productItem,
                  size: widget.size,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}