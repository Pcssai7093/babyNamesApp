import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/ObjectBox/NamesModelTeluguLiked.dart';
import 'package:baby_names/Pages/LikedList/nameItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<NameDataLiked> names = [];
  String selectedLetter = "ఆ";
  bool isLoading = false;

  final nameBoxLiked = objectbox.store.box<NameDataLiked>();


  void filterHandler(String firstLetter) async {
    setLoader(true);
    await Future.delayed(Duration(seconds: 1));
    print("selected filters: ,${firstLetter}");
    final query = nameBoxLiked
        .query(NameDataLiked_.firstLetterTelugu.equals(firstLetter))
        .build();
    final results = query.find();
    query.close();

    final query2 = nameBoxLiked
        .query(NameDataLiked_.firstLetterTelugu.notEquals(firstLetter))
        .build();
    final results2 = query2.find();
    query2.close();

    setState(() {
      names = [...results,...results2];
    });
    print(names.length);
    setLoader(false);
  }

  void setLoader(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  late DarkModeProvder darkModeProvder;

  @override
  Widget build(BuildContext context) {
    darkModeProvder = Provider.of<DarkModeProvder>(context);
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      body: Container(
        width: double.infinity, // Takes full available width
        height: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        decoration: BoxDecoration(
          color: darkModeProvder.isDarkMode ? Colors.black : Colors.white
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                navbar(filtersSelectd: filterHandler, setLoader: setLoader),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Determine the number of columns based on screen width
                        int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                        // 1 column if width < 600px (mobile), 3 columns if wider (tablet/desktop)

                        return GridView.builder(
                          itemCount: names.length,
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            childAspectRatio: 4, // Adjust height-to-width ratio
                          ),
                          itemBuilder: (context, index) {
                            return nameItem(nameData: names[index], setLoader: setLoader,);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            bottomNavBar(),
          ],
        ),
      ),
    );
  }
}
