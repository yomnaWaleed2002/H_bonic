import 'package:get/get.dart';
import 'package:h_bionic/utils/arabic.dart';
import 'package:h_bionic/utils/english.dart';

class Translation implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'ur_PK': ur_PK,
      };
}
