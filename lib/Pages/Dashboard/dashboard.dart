import 'dart:ui';

import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/Pages/Dashboard/card.dart';
import 'package:baby_names/Pages/Dashboard/navbar.dart';
import 'package:baby_names/Services/apiService.dart';
import 'package:baby_names/constants/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ObjectBox/NamesModelTelugu.dart';
import '../../Providers/darkMode.dart';
import '../../main.dart';
import '../../objectbox.g.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  final String title = "Dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late DarkModeProvder darkModeProvder;
  Dio dio = DioClient().dio;

  bool isLoading = false;

  late SharedPreferences prefs;

  Future<void> getAllNames() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('teluguNames');

    QuerySnapshot snapshot = await users.get();

    final userBox = objectbox.store.box<NameData>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedNames = prefs.getStringList("liked_names") ?? [];

    for (var doc in snapshot.docs) {
      final existingQuery =
          userBox.query(NameData_.docId.equals(doc.id)).build();
      final existingNames = existingQuery.find();
      existingQuery.close();

      if (existingNames.isNotEmpty) continue;

      NameData? nameData;
      if (likedNames.contains(doc.id)) {
        nameData = NameData.fromJson(
            doc.data() as Map<String, dynamic>, 0, doc.id, true);
      } else {
        nameData = NameData.fromJson(
            doc.data() as Map<String, dynamic>, 0, doc.id, false);
      }

      userBox.put(nameData);
    }

    print("total name fetched are ${userBox.count()}");
  }

  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      setLoader(true);
      await getAllNames();
      prefs = await SharedPreferences.getInstance();
      setLoader(false);
    });
  }

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }

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
                navbar(setLoader: setLoader),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        const card(
                          title: Strings.GenZ,
                          bgColor: Color.fromARGB(255, 190, 213, 221),
                          image: "assets/images/babyBoss1.png",
                        ),
                        SizedBox(height: 5),
                        const card(
                          title: Strings.traditional,
                          bgColor: Color.fromARGB(255, 235, 163, 164),
                          image: "assets/images/tradBaby1.png",
                        ),
                        SizedBox(height: 5),
                        const card(
                          title: Strings.spiritual,
                          bgColor: Color.fromARGB(255, 168, 206, 180),
                          image: "assets/images/spirBaby1.png",
                        ),
                        SizedBox(height: 5),
                        const card(
                          title: Strings.modern,
                          bgColor: Color.fromARGB(255, 168, 206, 180),
                          image: "assets/images/modernBaby1.png",
                        ),
                        SizedBox(height: 150),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Expanded(
                        //       child:
                        //     ),
                        //     SizedBox(width: 5),
                        //     Expanded(
                        //       child:
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavBar(),
            if (isLoading)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0), // Blur effect
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.3), // Semi-transparent overlay
                    alignment: Alignment.center,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.amberAccent,
                      size: 50,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
