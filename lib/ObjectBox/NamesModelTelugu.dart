import 'package:objectbox/objectbox.dart';

@Entity()
class NameData {
  int id;
  @Index()
  String docId;
  String gender;
  String religion;
  bool isLiked;

  String englishName;
  @Index()
  String firstLetterEnglish;

  String teluguName;
  @Index()
  String firstLetterTelugu;

  // String hindiName;
  // String firstLetterHindi;
  //
  // String bengaliName;
  // String firstLetterBengali;
  //
  // String tamilName;
  // String firstLetterTamil;
  //
  // String gujaratiName;
  // String firstLetterGujarati;
  //
  // String kannadaName;
  // String firstLetterKannada;
  //
  // String odiaName;
  // String firstLetterOdia;
  //
  // String malayalamName;
  // String firstLetterMalayalam;
  //
  // String punjabiName;
  // String firstLetterPunjabi;

  NameData({
    this.id = 0,
    required this.docId,
    required this.englishName,
    required this.teluguName,
    required this.firstLetterEnglish,
    required this.firstLetterTelugu,
    required this.gender,
    required this.religion,
    required this.isLiked,

    // required this.hindiName,
    // required this.firstLetterHindi,
    // required this.bengaliName,
    // required this.firstLetterBengali,
    // required this.tamilName,
    // required this.firstLetterTamil,
    // required this.gujaratiName,
    // required this.firstLetterGujarati,
    // required this.kannadaName,
    // required this.firstLetterKannada,
    // required this.odiaName,
    // required this.firstLetterOdia,
    // required this.malayalamName,
    // required this.firstLetterMalayalam,
    // required this.punjabiName,
    // required this.firstLetterPunjabi,
  });

  factory NameData.fromJson(
      Map<String, dynamic> json, int objectBoxId, String docId, bool isLiked) {
    //Tags are now passed separately.
    return NameData(
        id: objectBoxId,
        docId: docId,
        englishName: json["eng"],
        teluguName: json["tel"],
        firstLetterEnglish: json["FLeng"],
        firstLetterTelugu: json["FLtel"],
        gender: json["gen"],
        religion: json["rel"],
        isLiked: isLiked,

        // hindiName: json["hi"],
        // firstLetterHindi: json["FLhi"],
        // bengaliName: json["be"],
        // firstLetterBengali: json["FLbe"],
        // tamilName: json["ta"],
        // firstLetterTamil: json["FLta"],
        // gujaratiName: json["gu"],
        // firstLetterGujarati: json["FLgu"],
        // kannadaName: json["ka"],
        // firstLetterKannada: json["FLka"],
        // odiaName: json["od"],
        // firstLetterOdia: json["FLod"],
        // malayalamName: json["ma"],
        // firstLetterMalayalam: json["FLma"],
        // punjabiName: json["pu"],
        // firstLetterPunjabi: json["FLpu"],
    );
  }
}
