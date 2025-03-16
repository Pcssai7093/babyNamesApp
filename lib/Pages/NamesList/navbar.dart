import 'package:flutter/material.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  List<String> teluguAlphabets = [
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

  String selectedReligion = "Hindu";
  String selectedGender = "female";
  String selectedPage = "nameBook";
  int selectedLetterIndex = 3;

  FixedExtentScrollController? scrollController = FixedExtentScrollController();

  void scrollToIndex(int index) {
    double itemHeight =
        80.0; // Approximate height of each item (change as needed)
    scrollController?.animateTo(
      index * itemHeight,
      duration: Duration(milliseconds: 700), // Adjust speed as needed
      curve: Curves.easeInOut, // Smooth scrolling effect
    );
  }

  void setReligion(String religion) {
    setState(() {
      selectedReligion = religion;
    });
  }

  void setGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  void initState() {
    super.initState();

    // Scroll to the 4th item (index 3) after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(selectedLetterIndex);
    });

    scrollController?.addListener((){
      setState(() {
        selectedLetterIndex = scrollController?.selectedItem ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
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
          )),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*
              should contain filter and letter selector
               */
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(left:5,right: 5),
                //       padding: EdgeInsets.all(3),
                //       decoration: BoxDecoration(
                //           color: selectedPage == "Hindu" ? Colors.greenAccent : null,
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: Colors.black, width: 1)
                //       ),
                //       child: Image.asset(
                //         "assets/images/house.png",
                //         height: 35,
                //         width: 35,
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left:5,right: 5),
                //       padding: EdgeInsets.all(3),
                //       decoration: BoxDecoration(
                //           color: selectedPage == "Hindu" ? Colors.greenAccent : null,
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: Colors.black, width: 1)
                //       ),
                //       child: Image.asset(
                //         "assets/images/bookNavigation.png",
                //         height: 35,
                //         width: 35,
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(left:5,right: 15),
                //       padding: EdgeInsets.all(3),
                //       decoration: BoxDecoration(
                //           color: selectedPage == "Hindu" ? Colors.greenAccent : null,
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: Colors.black, width: 1)
                //       ),
                //       child: Image.asset(
                //         "assets/images/heartGreen1.png",
                //         height: 35,
                //         width: 35,
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(20)
                //         ),
                //         padding: EdgeInsets.only(left: 10,right:10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             // Image.asset(
                //             //   "assets/images/search.png",
                //             //   height: 30,
                //             //   width: 30,
                //             // ),
                //             Expanded(
                //               child: SizedBox(
                //                 child: TextField(
                //                   style: TextStyle(
                //                   color: Colors.black, // Text color
                //                   fontSize: 18, // Font size
                //                   fontWeight: FontWeight.normal,// Font weight
                //                 ),
                //                   decoration: InputDecoration(
                //                     border: InputBorder.none,
                //                     hintText: 'Enter a search term',
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Image.asset(
                //               "assets/images/clear.png",
                //               height: 30,
                //               width: 30,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setReligion("Hindu");
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: selectedReligion == "Hindu"
                                    ? Colors.orange
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.asset(
                              "assets/images/vishnu.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setReligion("Christian");
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: selectedReligion == "Christian"
                                    ? Colors.white
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.asset(
                              "assets/images/jesus.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setReligion("Muslim");
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: selectedReligion == "Muslim"
                                    ? Colors.green
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.asset(
                              "assets/images/prayingMuslim.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setGender("male");
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: selectedGender == "male"
                                    ? Colors.greenAccent
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.asset(
                              "assets/images/boyIcon1.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setGender("female");
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: selectedGender == "female"
                                    ? Colors.pinkAccent
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.asset(
                              "assets/images/girlIcon1.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: ListWheelScrollView.useDelegate(
                      offAxisFraction: 1,
                      physics: FixedExtentScrollPhysics(),
                      itemExtent: 80,
                      clipBehavior: Clip.none,
                      controller: scrollController,
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: teluguAlphabets.length,
                          builder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedLetterIndex = index;
                                });
                                scrollToIndex(index);
                              },
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(50),
                                      border: selectedLetterIndex == index
                                          ? Border.all(
                                              color: Colors.orange, width: 2)
                                          : null),
                                  height: 80,
                                  child: Text(
                                    teluguAlphabets[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "anekTeluguSemiBold"),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ), // Takes full available width
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
