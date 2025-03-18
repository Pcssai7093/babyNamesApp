import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/Pages/Dashboard/card.dart';
import 'package:baby_names/Pages/Dashboard/navbar.dart';
import 'package:baby_names/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/darkMode.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  final String title = "Dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late DarkModeProvder darkModeProvder;

  @override
  Widget build(BuildContext context) {
    darkModeProvder = Provider.of<DarkModeProvder>(context);

    return Scaffold(
      body: Container(
        width: double.infinity, // Takes full available width
        height: double.infinity,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        decoration: BoxDecoration(
          color: darkModeProvder.isDarkMode ? Colors.black : Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const navbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        const card(title:Strings.allNames, bgColor: Color.fromARGB(255,190, 213, 221),image: "assets/images/boyGirl1.png",),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: const card(title:Strings.boyNames, bgColor: Color.fromARGB(255,235, 163, 164),image: "assets/images/boyIcon1.png",),),
                            SizedBox(width: 5),
                            Expanded(child: const card(title:Strings.girlNames, bgColor: Color.fromARGB(255,168, 206, 180),image: "assets/images/girlIcon1.png",),),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavBar()
          ],
        ),

      ),
    );
  }
}
