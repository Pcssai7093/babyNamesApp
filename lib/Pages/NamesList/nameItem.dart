import 'dart:math';

import 'package:flutter/material.dart';

class nameItem extends StatelessWidget {
  const nameItem({super.key, this.nameData});
  static bool isLiked = true;
  final dynamic? nameData;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 50, // Minimum height of 100 pixels
      ),
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 163, 164),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
          boy/girl icon or some identitfier,
          name(can be native lagugage with english subtesxt),
          name like button,
           */
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              nameData?["gender"] == "male" ?
              Image.asset(
                "assets/images/boyIcon1.png",
                height: min(100,screenWidth * 0.07), // Scaled height
                width: min(100,screenWidth * 0.07), // Scaled width
              ):
              nameData?["gender"] == "female" ?
              Image.asset(
                "assets/images/girlIcon1.png",
                height: min(100,screenWidth * 0.07), // Scaled height
                width: min(100,screenWidth * 0.07), // Scaled width
              ):
              Image.asset(
                "assets/images/boyGirl1.png",
                height: min(100,screenWidth * 0.07), // Scaled height
                width: min(100,screenWidth * 0.07), // Scaled width
              ),
              Container(
                padding: EdgeInsets.only(left: max(4,screenWidth * 0.01),right: max(4,screenWidth * 0.01)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*
                name in native language big,
                name in english subtext
                 */
                    Text(
                      nameData?["name"]?["telugu"] ?? "N/A",
                      style:
                      TextStyle(fontSize: 20, fontFamily: "anekTeluguSemiBold"),
                    ),
                    Text(nameData?["name"]?["english"] ?? "N/A",
                      style:
                      TextStyle(fontSize: 15, fontFamily: "anekTeluguSemiBold"),)
                  ],
                ),
              ),
            ],
          ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("Tapped2!");
                    },
                    splashColor: Colors.blue.withOpacity(1), // Ripple effect
                    highlightColor: Colors.blue.withOpacity(0.2), // Pressed effect
                    borderRadius: BorderRadius.circular(80), // Optional rounded effect
                    child: Image.asset(
                      "assets/images/megaphone1.png",
                      height: min(100,screenWidth * 0.07), // Scaled height
                      width: min(100,screenWidth * 0.07),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                isLiked?
                Image.asset(
                  "assets/images/heartBlack1.png",
                  height: min(100,screenWidth * 0.07), // Scaled height
                  width: min(100,screenWidth * 0.07),
                ):
                Image.asset(
                  "assets/images/heartBlack1.png",
                  height: min(100,screenWidth * 0.07), // Scaled height
                  width: min(100,screenWidth * 0.07),
                ),
              ],
            )

        ],
      ),
    );
  }
}
