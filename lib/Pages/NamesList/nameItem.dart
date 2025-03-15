import 'package:flutter/material.dart';

class nameItem extends StatelessWidget {
  const nameItem({super.key});
  static bool isLiked = true;
  @override
  Widget build(BuildContext context) {
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
        children: [
          /*
          boy/girl icon or some identitfier,
          name(can be native lagugage with english subtesxt),
          name like button,
           */
          Row(
            children: [
              Image.asset(
                "assets/images/girlIcon1.png",
                height: 30,
                width: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 4,right: 4),
                child: Column(
                  children: [
                    /*
                name in native language big,
                name in english subtext
                 */
                    Text(
                      "ఆగ్నికుమార్",
                      style:
                      TextStyle(fontSize: 20, fontFamily: "anekTeluguSemiBold"),
                    ),
                    Text("Agni kumar",
                      style:
                      TextStyle(fontSize: 15, fontFamily: "anekTeluguSemiBold"),)
                  ],
                ),
              ),
            ],
          ),
            isLiked?
            Image.asset(
              "assets/images/heartGreen1.png",
              height: 30,
              width: 30,
            ):
            Image.asset(
              "assets/images/heartBlack1.png",
              height: 30,
              width: 30,
            ),
        ],
      ),
    );
  }
}
