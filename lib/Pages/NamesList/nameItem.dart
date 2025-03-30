import 'dart:math';

import 'package:baby_names/ObjectBox/NamesModelTelugu.dart';
import 'package:baby_names/ObjectBox/NamesModelTeluguLiked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../main.dart';
import '../../objectbox.g.dart';

class nameItem extends StatefulWidget {
  const nameItem({super.key, this.nameData, required this.setLoader, required this.index});

  final NameData? nameData;

  final int index;

  final void Function(bool) setLoader;

  @override
  State<nameItem> createState() => _nameItemState();
}

class _nameItemState extends State<nameItem> {
  var nameBoxLiked = objectbox.store.box<NameDataLiked>();
  var nameBox = objectbox.store.box<NameData>();

  bool isLiked = false;

  void speakText(String text) async {
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      widget.setLoader(true);
      setState(() {
        isLiked = widget.nameData?.isLiked ?? false;
      });
      // print(isLiked);
      widget.setLoader(false);
    });
  }


  void likeHandler(bool isLiked) async{
    widget.setLoader(true);
    await Future.delayed(Duration(seconds: 1));
    NameData? currentNameData = nameBox.get(widget.nameData?.id ?? 0);
    if(currentNameData != null){
      String currentNameDocid = currentNameData.docId;
      List<NameDataLiked> exitingNameQuery = nameBoxLiked
          .query(NameDataLiked_.docId.equals(currentNameDocid))
          .build()
          .find();

      if(exitingNameQuery.isEmpty){
        if(isLiked){
          NameDataLiked? currentNameDataLiked = NameDataLiked.fromNameDatat(currentNameData, true);
          nameBoxLiked.put(currentNameDataLiked);
          currentNameData.isLiked = true;
          nameBox.put(currentNameData);
        }
        else{
          currentNameData.isLiked = false;
          nameBox.put(currentNameData);
        }
      }else {
        if (isLiked) {
          currentNameData.isLiked = true;
          nameBox.put(currentNameData);
        }
        else {
          final query = nameBoxLiked.query(
              NameDataLiked_.docId.equals(currentNameDocid)).build();
          nameBoxLiked.removeMany(query.findIds()); // Remove matching entries
          query.close(); // Always close the query after use
          currentNameData.isLiked = false;
          nameBox.put(currentNameData);
        }
      }
    }

    widget.setLoader(false);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 50, // Minimum height of 100 pixels
      ),
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 163, 164),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
          boy/girl icon or some identitfier,
          name(can be native lagugage with english subtesxt),
          name like button,
           */
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "${widget.index + 1}. ",
                style: TextStyle(
                  fontSize: max(20,screenWidth*0.03),
                  fontFamily: "anekTeluguSemiBold"
                ),
              ),
              widget.nameData?.gender == "male" ?
              Image.asset(
                "assets/images/boyIcon1.png",
                height: min(100,screenWidth * 0.06), // Scaled height
                width: min(100,screenWidth * 0.06), // Scaled width
              ):
              widget.nameData?.gender == "female" ?
              Image.asset(
                "assets/images/girlIcon1.png",
                height: min(100,screenWidth * 0.06), // Scaled height
                width: min(100,screenWidth * 0.06), // Scaled width
              ):
              Image.asset(
                "assets/images/boyGirl1.png",
                height: min(100,screenWidth * 0.06), // Scaled height
                width: min(100,screenWidth * 0.06), // Scaled width
              ),
              Container(
                padding: EdgeInsets.only(left: max(4,screenWidth * 0.01),right: max(4,screenWidth * 0.01)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                name in native language big,
                name in english subtext
                 */
                    Text(
                      widget.nameData?.teluguName ?? "N/A",
                      style:
                      TextStyle(fontSize: 20, fontFamily: "anekTeluguSemiBold"),
                    ),
                    Text(widget.nameData?.englishName ?? "N/A",
                      style:
                      TextStyle(fontSize: 15, fontFamily: "anekTeluguSemiBold"),)
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("Tapped2!");
                    flutterTts.speak(widget.nameData?.teluguName ?? "");
                  },
                  splashColor: Colors.blue.withOpacity(1), // Ripple effect
                  highlightColor: Colors.blue.withOpacity(0.2), // Pressed effect
                  borderRadius: BorderRadius.circular(80), // Optional rounded effect
                  child: Image.asset(
                    "assets/images/megaphone1.png",
                    height: min(100,screenWidth * 0.06), // Scaled height
                    width: min(100,screenWidth * 0.06),
                  ),
                ),
              ),

              SizedBox(width: 10),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isLiked = !(widget.nameData?.isLiked ?? false);
                  });
                  widget.nameData?.isLiked = isLiked;
                  likeHandler(isLiked);
                  print("tapped like");
                  print(isLiked);
                },
                child: widget.nameData?.isLiked ?? false?
                Image.asset(
                  "assets/images/heartGreen1.png",
                  height: min(100,screenWidth * 0.06), // Scaled height
                  width: min(100,screenWidth * 0.06),
                ):
                Image.asset(
                  "assets/images/heartBlack1.png",
                  height: min(100,screenWidth * 0.06), // Scaled height
                  width: min(100,screenWidth * 0.06),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}


