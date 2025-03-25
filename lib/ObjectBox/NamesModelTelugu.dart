import 'package:objectbox/objectbox.dart';

@Entity()
class NameData {
  int id;
  @Index()
  String docId;
  String englishName;
  String teluguName;
  String firstLetterEnglish;
  @Index()
  String firstLetterTelugu;
  String gender;
  String language;
  String religion;
  String meaningEnglish;
  String meaningTelugu;
  String origin;
  List<String> tags;
  bool isLiked;

  NameData({
    this.id = 0,
    required this.docId,
    required this.englishName,
    required this.teluguName,
    required this.firstLetterEnglish,
    required this.firstLetterTelugu,
    required this.gender,
    required this.language,
    required this.religion,
    required this.meaningEnglish,
    required this.meaningTelugu,
    required this.origin,
    required this.tags,
    required this.isLiked,
  });

  factory NameData.fromJson(Map<String, dynamic> json, int objectBoxId, String docId, bool isLiked) { //Tags are now passed separately.
    return NameData(
      id: objectBoxId,
      docId : docId,
      englishName: json["name"]["english"],
      teluguName: json["name"]["telugu"],
      firstLetterEnglish: json["first_letter"]["english"],
      firstLetterTelugu: json["first_letter"]["telugu"],
      gender: json["gender"],
      language: json["language"],
      religion: json["religion"],
      meaningEnglish: json["meanings"]["english"],
      meaningTelugu: json["meanings"]["telugu"],
      origin: json["origin"],
      tags: json["tags"].cast<String>(),
      isLiked: isLiked
    );
  }
}
