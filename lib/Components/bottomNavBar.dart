import 'package:flutter/material.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  String? selectedPage = "/";

  @override
  Widget build(BuildContext context) {
    selectedPage = ModalRoute.of(context)?.settings.name;

    return Positioned(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).viewPadding.bottom + 30, //
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      "/"
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left:5,right: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedPage == "/" ? Colors.greenAccent : null,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.black, width: 1)
                  ),
                  child: Image.asset(
                    "assets/images/house.png",
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      "/nameList"
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left:5,right: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedPage == "/nameList" ? Colors.greenAccent : null,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.black, width: 1)
                  ),
                  child: Image.asset(
                    "assets/images/bookNavigation.png",
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      "/likedList"
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left:5,right: 15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedPage == "/likedList" ? Colors.greenAccent : null,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.black, width: 1)
                  ),
                  child: Image.asset(
                    "assets/images/heartGreen1.png",
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      "/likedList"
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left:5,right: 15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedPage == "Hind" ? Colors.greenAccent : null,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.black, width: 1)
                  ),
                  child: Image.asset(
                    "assets/images/tool.png",
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              // Image.asset(
              //   "assets/images/search.png",
              //   height: 35,
              //   width: 35,
              // ),
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     padding: EdgeInsets.only(left: 10,right:10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Expanded(
              //           child: SizedBox(
              //             child: TextField(
              //               style: TextStyle(
              //                 color: Colors.black, // Text color
              //                 fontSize: 18, // Font size
              //                 fontWeight: FontWeight.normal,// Font weight
              //               ),
              //               decoration: InputDecoration(
              //                 border: InputBorder.none,
              //                 hintText: 'Enter a search term',
              //               ),
              //             ),
              //           ),
              //         ),
              //         Image.asset(
              //           "assets/images/clear.png",
              //           height: 30,
              //           width: 30,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
