import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvder extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode; // Getter for dark mode

  DarkModeProvder() {
    _loadDarkModePreference(); // Load saved preference on startup
  }

  void _loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false; // Default to false if no value is saved
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void toggle() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode); // Save preference
    print("Dark mode toggled: $_isDarkMode");
    notifyListeners();
  }
}