import 'package:baby_names/Providers/darkMode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  String? selectedPage = "/";

  bool isMoreToolsSelected = false;
  bool expandTools = false;
  bool opacityTools = false;
  bool isDarkMode = false;

  late DarkModeProvder darkModeProvder;

  void toggleMoreTools(){
    print("togg");
    setState(() {
      isMoreToolsSelected = !isMoreToolsSelected;
    });
    print(isMoreToolsSelected);
    if(isMoreToolsSelected) {
      setState(() {
        expandTools = true;
        opacityTools = true;
      });
    }else {
      setState(() {
        expandTools = false;
        opacityTools = false;
      });
    }
  }

  void toggleDarkMode(){
    setState(() {
      isDarkMode = !isDarkMode;
    });
    darkModeProvder.toggle();
  }



  @override
  Widget build(BuildContext context) {
    selectedPage = ModalRoute.of(context)?.settings.name;
    darkModeProvder = Provider.of<DarkModeProvder>(context);

    return Positioned(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).viewPadding.bottom + 30, //
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)
          ),
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
                      color: Colors.blueAccent,
                        borderRadius: !expandTools ? BorderRadius.circular(20) :
                        BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        )
                    ),
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
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                  ),
                                  child: darkModeProvder.isDarkMode ? Image.asset(
                                    "assets/images/bulbOff.png",
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                  ):
                                  Image.asset(
                                    "assets/images/bulbOn.png",
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                  ),
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
                      color: Colors.blueAccent,
                      borderRadius: !expandTools ? BorderRadius.circular(20) :
                          BorderRadius.only(
                              topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                          )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: selectedPage == "/" ? Colors.greenAccent : null,
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
                          Navigator.pushNamed(context, "/nameList");
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
                          Navigator.pushNamed(context, "/likedList");
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
                          decoration: BoxDecoration(

                          ),
                          child: !expandTools ? Image.asset(
                            "assets/images/tool.png",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
                          ):
                          Image.asset(
                            "assets/images/close.png",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
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
