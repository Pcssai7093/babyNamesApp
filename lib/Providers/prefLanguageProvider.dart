import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefLanguageProvider extends ChangeNotifier {
  String _prefLanguage = "english";

  String get prefLang => _prefLanguage; // Getter for dark mode

  PrefLanguageProvider() {
    _loadPreference(); // Load saved preference on startup
  }

  void _loadPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _prefLanguage = prefs.getString('prefLang') ?? "telugu"; // Default to false if no value is saved
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void setLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefLang', lang); // Save preference
    print("pref language selected: $lang");
    _prefLanguage = lang ?? "english";
    notifyListeners();
  }
}