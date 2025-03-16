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
      height: 150,
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
