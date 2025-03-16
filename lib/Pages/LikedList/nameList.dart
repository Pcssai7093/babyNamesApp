import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:baby_names/Components/bottomNavBar.dart';
import 'package:baby_names/Pages/LikedList/nameItem.dart';
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
  List<dynamic> names = [
    {
      "id": "101",
      "name": {
        "english": "Aarav",
        "hindi": "आरव",
        "telugu": "ఆరవ్",
        "tamil": "ஆராவ்",
        "bengali": "আরভ",
        "kannada": "ಆರವ್",
        "marathi": "आरव"
      },
      "gender": "male",
      "language": ["hindi", "marathi"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Peaceful, Wise",
        "hindi": "शांत, बुद्धिमान",
        "telugu": "శాంతి, తెలివైన"
      },
      "origin": "Sanskrit",
      "tags": ["modern", "short", "trendy"]
    },
    {
      "id": "111",
      "name": {
        "english": "Arya",
        "hindi": "आर्य",
        "telugu": "ఆర్య",
        "tamil": "ஆர்யா",
        "bengali": "আর্য",
        "kannada": "ಆರ್ಯ",
        "marathi": "आर्य"
      },
      "gender": "neutral",
      "language": ["sanskrit", "hindi"],
      "religion": ["Hindu", "Buddhist"],
      "meaning": {
        "english": "Noble, Honorable",
        "hindi": "श्रेष्ठ, सम्माननीय",
        "telugu": "ఉన్నతమైన, గౌరవనీయమైన"
      },
      "origin": "Sanskrit",
      "tags": ["classic", "spiritual"]
    },
    {
      "id": "102",
      "name": {
        "english": "Advika",
        "hindi": "अद्विका",
        "telugu": "అద్వికా",
        "tamil": "அத்விகா",
        "bengali": "অদ্বিকা",
        "kannada": "ಅದ್ವಿಕಾ",
        "marathi": "अद्विका"
      },
      "gender": "female",
      "language": ["hindi", "telugu"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Unique, Goddess Durga",
        "hindi": "अद्वितीय, दुर्गा माता",
        "telugu": "అద్వితీయ, దుర్గాదేవి"
      },
      "origin": "Sanskrit",
      "tags": ["spiritual", "rare", "divine"]
    },
    {
      "id": "103",
      "name": {
        "english": "Zayan",
        "hindi": "ज़ायन",
        "telugu": "జయన్",
        "tamil": "ஜயன்",
        "bengali": "জায়ান",
        "kannada": "ಜಯನ್",
        "marathi": "झायन"
      },
      "gender": "male",
      "language": ["urdu", "hindi"],
      "religion": ["Muslim"],
      "meaning": {
        "english": "Bright, Graceful",
        "hindi": "उज्ज्वल, सुंदर",
        "telugu": "ప్రకాశవంతమైన, గౌరవప్రదమైన"
      },
      "origin": "Arabic",
      "tags": ["modern", "stylish", "meaningful"]
    },
    {
      "id": "104",
      "name": {
        "english": "Ishani",
        "hindi": "ईशानी",
        "telugu": "ఈశాని",
        "tamil": "ஈஷானி",
        "bengali": "ঈশানী",
        "kannada": "ಈಶಾನಿ",
        "marathi": "ईशानी"
      },
      "gender": "female",
      "language": ["hindi", "bengali"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Goddess Durga, Consort of Lord Shiva",
        "hindi": "दुर्गा माता, शिव जी की पत्नी",
        "telugu": "దుర్గాదేవి, శివుడి భార్య"
      },
      "origin": "Sanskrit",
      "tags": ["mythological", "divine", "beautiful"]
    },
    {
      "id": "105",
      "name": {
        "english": "Rehan",
        "hindi": "रेहान",
        "telugu": "రేహాన్",
        "tamil": "ரேஹான்",
        "bengali": "রেহান",
        "kannada": "ರೇಹಾನ್",
        "marathi": "रेहान"
      },
      "gender": "male",
      "language": ["urdu", "hindi"],
      "religion": ["Muslim"],
      "meaning": {
        "english": "Fragrant, Sweet Basil",
        "hindi": "सुगंधित, तुलसी का पौधा",
        "telugu": "సువాసన, తులసి మొక్క"
      },
      "origin": "Arabic",
      "tags": ["nature", "spiritual", "classic"]
    },
    {
      "id": "106",
      "name": {
        "english": "Meera",
        "hindi": "मीरा",
        "telugu": "మీరా",
        "tamil": "மீரா",
        "bengali": "মীরা",
        "kannada": "ಮೀರಾ",
        "marathi": "मीरा"
      },
      "gender": "female",
      "language": ["hindi", "gujarati"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Devotee of Lord Krishna",
        "hindi": "भगवान कृष्ण की भक्त",
        "telugu": "కృష్ణుని భక్తురాలు"
      },
      "origin": "Sanskrit",
      "tags": ["spiritual", "traditional", "short"]
    },
    {
      "id": "107",
      "name": {
        "english": "Vivaan",
        "hindi": "विवान",
        "telugu": "వివాన్",
        "tamil": "விவான்",
        "bengali": "বিভান",
        "kannada": "ವಿವಾನ್",
        "marathi": "विवान"
      },
      "gender": "male",
      "language": ["hindi", "telugu"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Full of Life",
        "hindi": "जीवन से भरपूर",
        "telugu": "జీవితం కలిగిన"
      },
      "origin": "Sanskrit",
      "tags": ["modern", "unique", "positive"]
    },
    {
      "id": "108",
      "name": {
        "english": "Fatima",
        "hindi": "फातिमा",
        "telugu": "ఫాతిమా",
        "tamil": "ஃபாத்திமா",
        "bengali": "ফাতিমা",
        "kannada": "ಫಾತಿಮಾ",
        "marathi": "फातिमा"
      },
      "gender": "female",
      "language": ["urdu", "hindi"],
      "religion": ["Muslim"],
      "meaning": {
        "english": "Daughter of Prophet Muhammad",
        "hindi": "पैगंबर मुहम्मद की बेटी",
        "telugu": "మహమ్మద్ ప్రవక్త కుమార్తె"
      },
      "origin": "Arabic",
      "tags": ["traditional", "historical", "beautiful"]
    },
    {
      "id": "109",
      "name": {
        "english": "Omkar",
        "hindi": "ओंकार",
        "telugu": "ఓంకార్",
        "tamil": "ஓம்கார்",
        "bengali": "ওংকার",
        "kannada": "ಓಂಕಾರ್",
        "marathi": "ओंकार"
      },
      "gender": "male",
      "language": ["hindi", "marathi"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Sacred Sound of Om",
        "hindi": "ओम का पवित्र ध्वनि",
        "telugu": "ఓం పవిత్ర ధ్వని"
      },
      "origin": "Sanskrit",
      "tags": ["spiritual", "sacred", "divine"]
    },
    {
      "id": "110",
      "name": {
        "english": "Sanya",
        "hindi": "सान्या",
        "telugu": "సాన్యా",
        "tamil": "ஸன்யா",
        "bengali": "সান্যা",
        "kannada": "ಸಾನ್ಯಾ",
        "marathi": "सान्या"
      },
      "gender": "female",
      "language": ["hindi", "punjabi"],
      "religion": ["Hindu"],
      "meaning": {
        "english": "Eminent, Distinguished",
        "hindi": "उल्लेखनीय, प्रसिद्ध",
        "telugu": "గుర్తింపు పొందిన"
      },
      "origin": "Sanskrit",
      "tags": ["modern", "short", "cute"]
    }
  ];
  String selectedPage = "Hindu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Takes full available width
        height: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const navbar(),
                Expanded(
                  child: Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: names.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return nameItem(nameData: names[index]);
                      },
                    ),
                  ),
                )
              ],
            ),
            bottomNavBar(),
          ],
        ),
      ),
    );
  }
}
