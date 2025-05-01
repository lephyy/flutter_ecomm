import 'package:flutter/material.dart';
import 'package:flutter_ecomm/models/model.dart';
import 'package:flutter_ecomm/utils/app_styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductDetail extends StatefulWidget {
  final AppModel productDetail;
  const ProductDetail({super.key, required this.productDetail});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor2,
        title: Text("Detail Product"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Iconsax.shopping_bag,
                size: 28,
              ),
              //We make it dynamic during backend part
              Positioned(
                  right: -3,
                  top: -5,
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
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: backgroundColor2,
            height: size.height*0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value){
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) {
                return Column(
                  children: [
                    Hero(
                      tag: '${widget.productDetail.name}_${widget.productDetail.image}',
                      child: Image.asset(
                        widget.productDetail.image,
                        height: size.height * 0.4,
                        width: size.width * 0.85,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index)=>AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          margin: EdgeInsets.only(right: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                              ? Colors.blue
                              : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Labubu",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.star,
                      color:Colors.amber,
                      size: 17,
                    ),
                    Text(widget.productDetail.rating.toString()),
                    Text(
                      "(${widget.productDetail.review.toInt()})",
                      style: const TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.favorite_border),
                  ],
                ),
                Text(
                  widget.productDetail.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Text("\$${widget.productDetail.price.toString()}.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.pink,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if(widget.productDetail.isCheck == true)
                      Text("\$${widget.productDetail.price + 255}.00",
                        style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black26,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15),
                Text("$myDescription1 ${widget.productDetail.name}$myDescription2",
                style:
                  const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                    letterSpacing: -.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //         width: size.width/2.1,
                //       child: Column(
                //         children: [
                //           Text(
                //             "Color",
                //             style: TextStyle(
                //               color: Colors.black54,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "ADD TO CART",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: -1,
                        )
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  color: Colors.black,
                  child: Center(
                    child: Text(
                        "BUY NOW",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: -1,
                        )
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
