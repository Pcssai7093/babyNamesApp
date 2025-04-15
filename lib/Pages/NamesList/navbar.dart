import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/darkMode.dart';
import '../../Providers/prefLanguageProvider.dart';
import '../../constants/string.dart';

class navbar extends StatefulWidget {
  const navbar({super.key,required this.filtersSelectd, required this.setLoader});

  final void Function(String, String, String) filtersSelectd;

  final void Function(bool) setLoader;

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
  Timer? _debounce;

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
    widget.filtersSelectd(selectedReligion, selectedGender, Strings.constants[prefLanguageProvider.prefLang]["alphabets"][selectedLetterIndex]);
  }

  void setGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.filtersSelectd(selectedReligion, selectedGender, Strings.constants[prefLanguageProvider.prefLang]["alphabets"][selectedLetterIndex]);
  }

  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();

    // Scroll to the 4th item (index 3) after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.setLoader(true);
      scrollToIndex(selectedLetterIndex);

      scrollController?.addListener((){
        setState(() {
          selectedLetterIndex = scrollController?.selectedItem ?? 0;
        });
        if (_debounce?.isActive ?? false) _debounce?.cancel();

        _debounce = Timer(Duration(milliseconds: 300), () {
          widget.filtersSelectd(selectedReligion, selectedGender, Strings.constants[prefLanguageProvider.prefLang]["alphabets"][selectedLetterIndex]);
        });
      });

      prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedGender = prefs.getString("prefGender") ?? "male";
        selectedReligion = prefs.getString("prefReligion") ?? "Hindu";
        var index = Strings.constants[prefLanguageProvider.prefLang]["alphabets"].indexOf(prefs.getString("prefLetter") ?? "ఈ");
        selectedLetterIndex = index == -1 ? 4 : index;
       });
      scrollToIndex(selectedLetterIndex);
      widget.filtersSelectd(selectedReligion, selectedGender, Strings.constants[prefLanguageProvider.prefLang]["alphabets"][selectedLetterIndex]);
      widget.setLoader(false);
    });


  }
  late DarkModeProvder darkModeProvder;
  late PrefLanguageProvider prefLanguageProvider;

  @override
  Widget build(BuildContext context) {
    darkModeProvder = Provider.of<DarkModeProvder>(context);
    prefLanguageProvider = context.watch<PrefLanguageProvider>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      decoration: BoxDecoration(
          color: darkModeProvder.isDarkMode ? Colors.blueGrey.shade800 : Colors.blueAccent,
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.height * 0.05,
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.height * 0.05,
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.height * 0.05,
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.height * 0.05,
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.height * 0.05,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: ListWheelScrollView.useDelegate(
                      offAxisFraction: 1,
                      physics: FixedExtentScrollPhysics(),
                      itemExtent: 80,
                      clipBehavior: Clip.none,
                      controller: scrollController,
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: Strings.constants[prefLanguageProvider.prefLang]["alphabets"].length,
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
                                    Strings.constants[prefLanguageProvider.prefLang]["alphabets"][index],
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
    scrollController?.dispose();
  }
}
