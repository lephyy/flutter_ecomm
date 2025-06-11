import 'package:flutter/material.dart';

class ProductModel{
  late final String name,image,description,category;
  late final double rating;
  late final double review,price;
  bool isCheck;

  ProductModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.price,
    required this.review,
    required this.description,
    required this.isCheck,
    required this.category,
  });
}

List<ProductModel> ProductSpecial = [
  ProductModel(
      name: "The MONSTERS COCA-COLA SERIES-Vinyl Face Blind Box",
      image: "assets/images/products/product1.png",
      rating: 4.5,
      price: 39.99,
      review: 136,
      description: "",
      isCheck: true,
      category: "Blind Boxes",
  ),
  ProductModel(
    name: "The MONSTERS COCA-COLA SERIES-Vinyl Face Blind Box",
    image: "assets/images/products/product1.png",
    rating: 4.5,
    price: 39.99,
    review: 136,
    description: "",
    isCheck: true,
    category: "Blind Boxes",
  ),
  ProductModel(
    name: "The MONSTERS COCA-COLA SERIES-Vinyl Face Blind Box",
    image: "assets/images/products/product1.png",
    rating: 4.5,
    price: 39.99,
    review: 136,
    description: "",
    isCheck: true,
    category: "Blind Boxes",
  ),
  ProductModel(
    name: "The MONSTERS COCA-COLA SERIES-Vinyl Face Blind Box",
    image: "assets/images/products/product1.png",
    rating: 4.5,
    price: 39.99,
    review: 136,
    description: "",
    isCheck: true,
    category: "Blind Boxes",
  ),
  ProductModel(
    name: "The MONSTERS COCA-COLA SERIES-Vinyl Face Blind Box",
    image: "assets/images/products/product1.png",
    rating: 4.5,
    price: 39.99,
    review: 136,
    description: "",
    isCheck: true,
    category: "Blind Boxes",
  ),
];

const myDescription1 = "Elevate your casual wardrobe with our";
const myDescription2 = " .Crafted from premium cotton for maximum comfort, this relaxed-fit tee featured";