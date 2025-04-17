import 'package:baby_names/Providers/darkMode.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/prefLanguageProvider.dart';
import 'interstitial_ad_service.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key, required this.prefLangSelectHanlder});

  final void Function(String) prefLangSelectHanlder;

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  String? selectedPage = "/";

  Map<String, String> firstAlphabets = {
    "english": "A", // Latin
    "telugu": "అ", // Telugu
    // "hindi": "अ", // Devanagari
    // "bengali": "অ", // Bengali
    // "tamil": "அ", // Tamil
    // "gujarati": "અ", // Gujarati
    // "kannada": "ಅ", // Kannada
    // "odia": "ଅ", // Odia
    // "malayalam": "അ", // Malayalam
    // "punjabi": "ਅ" // Gurmukhi
  };

  bool isMoreToolsSelected = false;
  bool expandTools = false;
  bool opacityTools = false;
  bool isDarkMode = false;
  bool _isNavigating = false;

  late DarkModeProvder darkModeProvder;
  late PrefLanguageProvider prefLanguageProvider;

  bool isLoading = false;

  void toggleMoreTools() {
    print("togg");
    setState(() {
      isMoreToolsSelected = !isMoreToolsSelected;
    });
    print(isMoreToolsSelected);
    if (isMoreToolsSelected) {
      setState(() {
        expandTools = true;
        opacityTools = true;
      });
    } else {
      setState(() {
        expandTools = false;
        opacityTools = false;
      });
    }
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    prefs.setBool("isDarkMode", !isDarkMode);
    darkModeProvder.toggle();
  }

  late SharedPreferences prefs;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
    });
  }

  void setLoader(bool value) {
    print(value);
    setState(() {
      isLoading = value;
    });
  }

  void showSimpleAlertDialog(BuildContext context, String title, String message,
      VoidCallback onOkPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String prefLanguageState = prefs.getString("prefLang") ?? "telugu";

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: darkModeProvder.isDarkMode
                    ? Colors.blueGrey.shade400
                    : Colors.blueAccent,
                content: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of items per row
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1, // Width/height ratio
                        ),
                        itemCount: firstAlphabets.entries.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          var entry = firstAlphabets.entries.toList()[index];
                          String language = entry.key;
                          String prefLanguage =
                              prefs.getString("prefLang") ?? "";
                          bool isLangSelected = language == prefLanguage;
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isLangSelected
                                  ? Colors.pinkAccent
                                  : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                Future.delayed(Duration(seconds: 1),
                                        () async {
                                      setState(() {
                                        prefLanguageState = language;
                                      });
                                      prefLanguageProvider.setLanguage(language);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                              },
                              child: Container(
                                  child: Text(
                                    entry.value,
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isLoading)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        alignment: Alignment.center,
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Image.asset(
                      "assets/images/close.png",
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.05,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onOkPressed();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    selectedPage = ModalRoute.of(context)?.settings.name;
    darkModeProvder = Provider.of<DarkModeProvder>(context);
    prefLanguageProvider = Provider.of<PrefLanguageProvider>(context);

    return Positioned(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).viewPadding.bottom +
          MediaQuery.of(context).size.height * 0.06, //
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 50),
                opacity: opacityTools ? 1 : 0,
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: darkModeProvder.isDarkMode
                            ? Colors.blueGrey.shade400
                            : Colors.blueAccent,
                        borderRadius: !expandTools
                            ? BorderRadius.circular(20)
                            : BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                    padding: expandTools ? EdgeInsets.all(10) : null,
                    child: Offstage(
                      offstage: expandTools ? false : true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, "/");
                          //   },
                          //   child: Container(
                          //     margin: EdgeInsets.only(left: 5, right: 5),
                          //     padding: EdgeInsets.all(5),
                          //     decoration: BoxDecoration(
                          //     ),
                          //     child: Image.asset(
                          //       "assets/images/house.png",
                          //       height: MediaQuery.of(context).size.height * 0.05,
                          //       width: MediaQuery.of(context).size.height * 0.05,
                          //     ),
                          //   ),
                          // ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  toggleDarkMode();
                                  // InterstitialAdService().showAd();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(),
                                  child: darkModeProvder.isDarkMode
                                      ? Image.asset(
                                          "assets/images/bulbOff.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        )
                                      : Image.asset(
                                          "assets/images/bulbOn.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // toggleDarkMode();
                                  showSimpleAlertDialog(context,
                                      "Select Language", "messag", () => {});
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(),
                                  child: Image.asset(
                                          "assets/images/lang.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        )
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 30)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      color: darkModeProvder.isDarkMode
                          ? Colors.blueGrey.shade400
                          : Colors.blueAccent,
                      borderRadius: !expandTools
                          ? BorderRadius.circular(20)
                          : BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!_isNavigating) {
                            _isNavigating = true;
                            InterstitialAdService().showAd(() {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage()));
                              Navigator.pushReplacementNamed(context, "/")
                                  .then((_) {
                                _isNavigating = false;
                              });
                            });
                            // Navigator.pushReplacementNamed(context, "/")
                            //     .then((_) {
                            //   _isNavigating = false;
                            // });
                          }

                          // Navigator.pushNamed(context, "/");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                selectedPage == "/" ? Colors.greenAccent : null,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black, width: 1)
                          ),
                          child: Image.asset(
                            "assets/images/house.png",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!_isNavigating) {
                            _isNavigating = true;

                            InterstitialAdService().showAd(() {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage()));
                              Navigator.pushReplacementNamed(context, "/nameList")
                                  .then((_) {
                                _isNavigating = false;
                              });
                            });

                            // Navigator.pushReplacementNamed(context, "/nameList")
                            //     .then((_) {
                            //   _isNavigating = false;
                            // });
                          }
                          // Navigator.pushNamed(context, "/nameList");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: selectedPage == "/nameList"
                                ? Colors.greenAccent
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black, width: 1)
                          ),
                          child: Image.asset(
                            "assets/images/bookNavigation.png",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!_isNavigating) {
                            _isNavigating = true;

                            InterstitialAdService().showAd(() {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage()));
                              Navigator.pushReplacementNamed(context, "/likedList")
                                  .then((_) {
                                _isNavigating = false;
                              });
                            });

                            // Navigator.pushReplacementNamed(
                            //         context, "/likedList")
                            //     .then((_) {
                            //   _isNavigating = false;
                            // });
                          }
                          // Navigator.pushNamed(context, "/likedList");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 15),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: selectedPage == "/likedList"
                                ? Colors.greenAccent
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black, width: 1)
                          ),
                          child: Image.asset(
                            "assets/images/heartGreen1.png",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          toggleMoreTools();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 15),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(),
                          child: !expandTools
                              ? Image.asset(
                                  "assets/images/tool.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                )
                              : Image.asset(
                                  "assets/images/close.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                        ),
                      ),
                    ],
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
