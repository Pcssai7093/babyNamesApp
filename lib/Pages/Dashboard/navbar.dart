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
      height: 320,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
        // left: 0,
        right: 20,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            columnWidths: {
              0: FlexColumnWidth(1), // Takes width based on content
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "లింగం",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "anekTeluguSemiBold"),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
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
                                  height: 60,
                                  width: 60,
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
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
              ),
              TableRow(
                children: [
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "మతం",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "anekTeluguSemiBold"),
                          ),
                        ),
                      )
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
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
                                height: 60,
                                width: 60,
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
                                height: 60,
                                width: 60,
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
                                height: 60,
                                width: 60,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]
              ),
              TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "అక్షరం",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "anekTeluguSemiBold"),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 60,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: ListWheelScrollView.useDelegate(
                              offAxisFraction: 2,
                              physics: FixedExtentScrollPhysics(),
                              itemExtent: 60,
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
                        ),
                      )
                    )
                  ]
              )
            ],
          ),
          // Column(
          //   children: [
          //    Container(
          //       alignment: Alignment.center,
          //       child: Text(
          //         "అక్షరం",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontFamily: "anekTeluguSemiBold"),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ), // Takes full available width
    );
  }
}
