import 'dart:ui';

import 'package:baby_names/Components/bottomBannerAd.dart';
import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/Pages/Dashboard/card.dart';
import 'package:baby_names/Pages/Dashboard/navbar.dart';
import 'package:baby_names/Pages/NamesList/nameItem.dart';
import 'package:baby_names/Providers/prefLanguageProvider.dart';
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
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  final String title = "Dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late DarkModeProvder darkModeProvder;
  late PrefLanguageProvider prefLanguageProvider;

  Dio dio = DioClient().dio;

  bool isLoading = false;
  bool isLoading2 = false;

  late SharedPreferences prefs;

  Future<void> getAllNames() async {
    setLoader2(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // checking if the pref has date of last fetchecd
    int lastTimeFetched = prefs.getInt("lastTimeFetched") ?? -1;

    if (lastTimeFetched != -1) {
      if (!isMoreThan24HoursOld(lastTimeFetched)) {
        print("fetched recently so skipping");
        return;
      }
    }

    final userBox = objectbox.store.box<NameData>();
    userBox.removeAll();

    List<String> likedNames = prefs.getStringList("liked_names") ?? [];

    final manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifest);

    // Filter JSON files in your folder
    final jsonFiles = manifestMap.keys.where((path) =>
        path.startsWith('assets/boyNamesTelugu/') && path.endsWith('.json'));

    final jsonFilesGirls = manifestMap.keys.where((path) =>
    path.startsWith('assets/girlNamesTelugu/') && path.endsWith('.json'));

    print(jsonFiles.length);
    print(jsonFilesGirls.length);

    List<NameData> newNameData = [];

    for (final filePath in jsonFiles) {
      try {
        final fileContent = await rootBundle.loadString(filePath);
        final jsonList = json.decode(fileContent) as List<dynamic>;

        for (var item in jsonList) {
          print("adding boy");
          NameData? nameData;
          if (false && likedNames.contains(item["id"])) {
            // nameData = NameData.fromJson(
            //     item as Map<String, dynamic>, 0, item["id"], true);
          } else {
            nameData = NameData.fromJson(
                item as Map<String, dynamic>, 0, item["id"], false);
          }
          newNameData.add(nameData);
        }
      } catch (e) {
        print('Error loading $filePath: $e');
      }
    }

    for (final filePath in jsonFilesGirls) {
      try {
        final fileContent = await rootBundle.loadString(filePath);
        final jsonList = json.decode(fileContent) as List<dynamic>;

        for (var item in jsonList) {
          print("adding girl");
          NameData? nameData;
          if (false && likedNames.contains(item["id"])) {
            nameData = NameData.fromJson(
                item as Map<String, dynamic>, 0, item["id"], true);
          } else {
            nameData = NameData.fromJson(
                item as Map<String, dynamic>, 0, item["id"], false);
          }

          newNameData.add(nameData);
        }
      } catch (e) {
        print('Error loading $filePath: $e');
      }
    }
    userBox.putMany(newNameData);
    prefs.setInt("lastTimeFetched", DateTime.now().millisecondsSinceEpoch);
    print("total name fetched are ${userBox.count()}");
    setLoader2(false);
  }

  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllNames();
      setLoader2(true);
      print("set loder trye");
      prefs = await SharedPreferences.getInstance();
      setLoader2(false);
    });
  }

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }
  void setLoader2(bool value) {
    setState(() {
      isLoading2 = value;
    });
  }

  bool isMoreThan24HoursOld(int millisecondsSinceEpoch) {
    // Convert stored timestamp to DateTime
    final storedDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    // Get current DateTime
    final now = DateTime.now();

    // Calculate the difference
    final difference = now.difference(storedDate);

    // Check if difference is more than 24 hours
    return difference.inHours > 120;
  }

  void prefLangSelectHanlder(String selectedLang) async{

  }

  @override
  Widget build(BuildContext context) {
    darkModeProvder = Provider.of<DarkModeProvder>(context);
    prefLanguageProvider = Provider.of<PrefLanguageProvider>(context);

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
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "male");
                                  await prefs.setString('prefReligion', "Hindu");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.GenZ,
                                  bgColor: Color.fromARGB(255, 190, 213, 221),
                                  image: "assets/images/hinduBoy1.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "female");
                                  await prefs.setString('prefReligion', "Hindu");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.traditional,
                                  bgColor: Color.fromARGB(255, 235, 163, 164),
                                  image: "assets/images/hinduGirl1.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "male");
                                  await prefs.setString('prefReligion', "Muslim");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.spiritual,
                                  bgColor: Color.fromARGB(255, 168, 206, 180),
                                  image: "assets/images/muslimBoy1.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "female");
                                  await prefs.setString('prefReligion', "Muslim");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.modern,
                                  bgColor: Color.fromARGB(255, 168, 206, 180),
                                  image: "assets/images/muslimGirl1.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "male");
                                  await prefs.setString('prefReligion', "Christian");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.GenZ,
                                  bgColor: Color.fromARGB(255, 190, 213, 221),
                                  image: "assets/images/christBoy1.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await prefs.setString('prefGender', "female");
                                  await prefs.setString('prefReligion', "Christian");
                                  Navigator.pushNamed(context, "/nameList");
                                },
                                child: const card(
                                  title: Strings.traditional,
                                  bgColor: Color.fromARGB(255, 235, 163, 164),
                                  image: "assets/images/christGirl1.png",
                                ),
                              ),
                            ),
                          ],
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
            bottomNavBar(prefLangSelectHanlder: prefLangSelectHanlder),
            bottomBannerAd(),
            if (isLoading || isLoading2)
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

  @override
  void dispose(){
    super.dispose();
  }
}
