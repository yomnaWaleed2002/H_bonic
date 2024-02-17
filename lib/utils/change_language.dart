import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Controller extends GetxController {
  void changelang(String codelang) {
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
  }
}
