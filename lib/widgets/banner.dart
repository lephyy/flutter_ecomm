import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.23,
      width: size.width,
      color: bannerColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 27),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New COLLECTIONS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
                ),
                Row(
                  children: [
                    Text("New COLLECTIONS",
                      style: TextStyle(
                        fontSize: 40,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -3,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "%",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "OFF",
                          style: TextStyle(
                          fontSize: 10,
                          letterSpacing: -1.5,
                          fontWeight: FontWeight.bold,
                          height: 0.6,
                        ),)
                      ],
                    )
                  ],
                ),
                MaterialButton(
                    onPressed: () {},
                    color: Colors.black12,
                    child: Text(
                      "SHOP NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Image.asset("assets/images/banner.png",
            //     height: size.height*0.19,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
