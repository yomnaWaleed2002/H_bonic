import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_bionic/pages/bottombar.dart';
//import 'package:senior_project/pages/firstScreen.dart';
import 'package:h_bionic/theme/theme_constants.dart';
import 'package:h_bionic/theme/theme_manager.dart';
import 'package:h_bionic/utils/translation.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? sharef;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharef = await SharedPreferences.getInstance();
  runApp((MyApp()));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Bottom_bar(),
      translations: Translation(),
      locale: Locale('en', 'US'),
       fallbackLocale: Locale('en'),
    );
  }
}

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<Setting> {
  bool click = true;
  bool click1 = true;
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Color(0xff466AFF),
                size: 57,
              ),
              title: Text(
                "Settings".tr,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 30,
                  fontFamily: 'Century Gothic',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
           Padding(
             padding: const EdgeInsets.only(top:30,left: 17,right: 17),
             child: Text(
                "theme".tr,
                style: TextStyle(
                    color: Color(0xFF459ED1),
                    fontSize: 24,
                    fontFamily: 'Century Gothic',
                    fontWeight: FontWeight.w400),
              ),
           ),
        
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: Row(
              children: [
                 Padding(
            padding: const EdgeInsets.only(top: 17),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.bedtime,
                      size: 30,
                      color: isDark ? Colors.black : Colors.white,
                    ),
                    backgroundColor: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Dark Mode".tr,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
                Padding(
                  padding: const EdgeInsets.only(top:24,right: 19,left: 19),
                  child: DayNightSwitcher(
                    dayBackgroundColor: Color.fromARGB(255, 184, 184, 186),
                    nightBackgroundColor: Color.fromARGB(236, 255, 255, 255),
                    starsColor: Colors.white,
                    cloudsColor: Colors.blue,
                    isDarkModeEnabled: _themeManager.themeMode == ThemeMode.dark,
                    onStateChanged: (newValue) {
                      _themeManager.toggleTheme(newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:30,left: 17,right: 17),
            child: Text(
              "language".tr,
              style: TextStyle(
                  color: Color(0xFF459ED1),
                  fontSize: 24,
                  fontFamily: 'Century Gothic',
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.language,
                      size: 30,
                      color: isDark ? Colors.black : Colors.white,
                    ),
                    backgroundColor: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "select language".tr,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 40,left: 40),
            child: Column(children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //click = !click;
                    Get.updateLocale(Locale('en', 'US'));
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: click
                      ? Color.fromARGB(255, 184, 184, 186)
                      : Color(0xFF616672),
                  fixedSize: const Size(342, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/en.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "English".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Century Gothic',
                          fontWeight: FontWeight.w400,
                          height: 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                     Get.updateLocale(Locale('ur', 'PK'));
                  });
                },
                // click1 = !click1;
                style: ElevatedButton.styleFrom(
                  backgroundColor: click1
                      ? Color.fromARGB(255, 184, 184, 186)
                      : Color(0xFF616672),
                  disabledBackgroundColor: Colors.black,
                  fixedSize: const Size(342, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/ar.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Arabic".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Century Gothic',
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}