import 'package:baby_names/Pages/NamesList/nameItem.dart';
import 'package:flutter/material.dart';

import '../../constants/string.dart';
import '../Dashboard/card.dart';
import './navbar.dart';

class nameList extends StatefulWidget {
  const nameList({super.key});

  @override
  State<nameList> createState() => _nameListState();
}

class _nameListState extends State<nameList> {

  /*
  {
    "id":"323",
    name:{
    "english":"ankur",
    "telugu":"అంకుర్‌",
    }
  }
  */
  List<dynamic> name = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Takes full available width
        height: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const navbar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      nameItem(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(child: const card(title:Strings.boyNames, bgColor: Color.fromARGB(255,235, 163, 164),image: "assets/images/babyBoy1.png",),),
                      //     SizedBox(width: 5),
                      //     Expanded(child: const card(title:Strings.girlNames, bgColor: Color.fromARGB(255,168, 206, 180),image: "assets/images/babyGirl1.png",),),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
