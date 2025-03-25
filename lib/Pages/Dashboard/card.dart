import 'dart:math';

import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({super.key, required this.title, required this.bgColor, required this.image});

  final Color bgColor;
  final String image;
  final String title;



  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 100, // Minimum height of 100 pixels
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "anekTeluguSemiBold"
              ),
            ),
            Offstage(
              offstage: image.isEmpty,
              child: Image.asset(
                image,
                width: 150, // Optional width
                height: 150, // Optional height
                fit: BoxFit.contain, // Adjust how the image fits
              ),
            )

          ],
        ));
  }
}
