import 'package:flutter/material.dart';

class DarkModeProvder extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode; // Getter for count

  void toggle() {
    _isDarkMode = !_isDarkMode;
    print("dark mode toggled");
    notifyListeners(); // Notifies widgets to rebuild
  }
}
