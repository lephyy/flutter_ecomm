class Category{
  late final String name,image;
  Category({required this.name,required this.image});
}

List<Category> category=[
  Category(
    name: "Blind Boxes",
    image: "assets/images/categorys/blindbox.png",
  ),
  Category(
    name: "Bags",
    image: "assets/images/categorys/category1.jpg",
  ),
  Category(
    name: "MEGA",
    image: "assets/images/categorys/mega.png",
  ),
  Category(
    name: "Figurine",
    image: "assets/images/categorys/category2.jpg",
  ),
  Category(
    name: "Plush Toys",
    image: "assets/images/categorys/category3.jpg",
  ),
];

List<String> filterCategory =[
  "Filter",
  "Ratings",
  "Price",
  "Brand"
];