import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  const navbar({super.key});
  static List<String> teluguAlphabets = [
    // Vowels (Achulu - అచ్చులు)
    "అ", "ఆ", "ఇ", "ఈ", "ఉ", "ఊ", "ఋ", "ఎ", "ఏ", "ఐ", "ఒ", "ఓ", "ఔ",

    // Consonants (Hallulu - హల్లులు)
    "క", "ఖ", "గ", "ఘ", "ఙ",
    "చ", "ఛ", "జ", "ఝ", "ఞ",
    "ట", "ఠ", "డ", "ఢ", "ణ",
    "త", "థ", "ద", "ధ", "న",
    "ప", "ఫ", "బ", "భ", "మ",
    "య", "ర", "ల", "వ", "శ", "ష", "స", "హ",
    "ళ", "క్ష", "ఱ"
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(
          // top: BorderSide(color: Colors.blue, width: 10),
          // left: BorderSide(color: Colors.green, width: 10),
          // right: BorderSide(color: Colors.orange, width: 10),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*
          should contain filter and letter selector
           */
          SizedBox(
            height: 100,
            child: RotatedBox(
              quarterTurns: 1,
              child: ListWheelScrollView(
                  offAxisFraction:2,
                  physics: FixedExtentScrollPhysics(),
                  itemExtent: 80,
                  clipBehavior: Clip.none,
                  children: teluguAlphabets.map((item) {
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 80,
                        child: Text(
                          item,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  }).toList(),
              ),
            ),
          )
        ],
      ),// Takes full available width
    );
  }
}
