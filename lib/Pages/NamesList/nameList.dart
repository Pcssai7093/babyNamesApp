import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/Components/nativeAdMedium.dart';
import 'package:baby_names/ObjectBox/NamesModelTeluguLiked.dart';
import 'package:baby_names/Pages/NamesList/nameItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ObjectBox/NamesModelTelugu.dart';
import '../../Providers/darkMode.dart';
import '../../constants/string.dart';
import '../../main.dart';
import '../../objectbox.g.dart';
import '../Dashboard/card.dart';
import './navbar.dart';

class nameList extends StatefulWidget {
  const nameList({super.key});

  @override
  State<nameList> createState() => _nameListState();
}

class _nameListState extends State<nameList> {
  // {
  // "id": "101",
  // "name": {
  // "english": "Aarav",
  // "hindi": "आरव",
  // "telugu": "ఆరవ్",
  // "tamil": "ஆராவ்",
  // "bengali": "আরভ",
  // "kannada": "ಆರವ್",
  // "marathi": "आरव"
  // },
  // "gender": "male",
  // "language": ["hindi", "marathi"],
  // "religion": ["Hindu"],
  // "meaning": {
  // "english": "Peaceful, Wise",
  // "hindi": "शांत, बुद्धिमान",
  // "telugu": "శాంతి, తెలివైన"
  // },
  // "origin": "Sanskrit",
  // "tags": ["modern", "short", "trendy"]
  // }
  List<NameData> names = [];

  String selectedReligion = "Hindu";
  String selectedGender = "male";
  String selectedLetter = "ఆ";
  bool isLoading = false;

  final nameBox = objectbox.store.box<NameData>();
  final ScrollController _scrollController = ScrollController();
  // final likedNameBox = objectbox.store.box<NameDataLiked>();

  late DarkModeProvder darkModeProvder;
  late SharedPreferences prefs;

  bool _nativeAdIsLoaded = false;

  NativeAd? _nativeAd ;

  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      setLoader(true);
      await Future.delayed(Duration(seconds: 2));
      prefs = await SharedPreferences.getInstance();
      setState(() {
        names = nameBox.getAll();
      });
      setLoader(false);
    });

  }

  void filterHandler(String religion, String gender, String firstLetter) async {
    setLoader(true);
    await Future.delayed(Duration(seconds: 1));
    print("selected filters: ${religion},${gender},${firstLetter}");
    final query = nameBox
        .query(NameData_.religion
            .equals(religion)
            .and(NameData_.gender.equals(gender))
            .and(NameData_.firstLetterTelugu.equals(firstLetter)))
        .build();
    final results = query.find();
    query.close();
    setState(() {
      names = results;
    });
    _scrollController.jumpTo(0);
    print(names);
    setLoader(false);
  }

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    darkModeProvder = Provider.of<DarkModeProvder>(context);
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      body: Container(
        width: double.infinity, // Takes full available width
        height: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        decoration: BoxDecoration(
            color: darkModeProvder.isDarkMode ? Colors.black : Colors.white),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                navbar(filtersSelectd: filterHandler, setLoader: setLoader,),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Determine the number of columns based on screen width
                            int crossAxisCount =
                            constraints.maxWidth > 600 ? 2 : 1;
                            // 1 column if width < 600px (mobile), 3 columns if wider (tablet/desktop)

                            return MasonryGridView.builder(
                              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount, // Number of columns
                              ),
                              controller: _scrollController,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 10,
                              itemCount: names.length,
                              itemBuilder: (context, index) {
                                if (index != 0 && index % 20 == 0) {
                                  return Column(
                                    children: [
                                      nativeAdMedium(),
                                      nameItem(index: index, nameData: names[index], setLoader: setLoader),
                                    ],
                                  );
                                } else {
                                  return nameItem(index: index, nameData: names[index], setLoader: setLoader);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      if(isLoading)
                      Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            bottomNavBar(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
