import 'package:flutter/material.dart';

class Myprovider with ChangeNotifier {
  String languageCode = 'en';

  void changelanguage(String lang) {
    languageCode = lang;
    notifyListeners();
  }
}
