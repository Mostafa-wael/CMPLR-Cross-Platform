import 'package:cmplr/views/android_views/master_page.dart';

import 'cmplr_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/android_views/android_views.dart';

Future<void> main() async {
  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MasterPage(),
      getPages: [
        GetPage(name: '/signup_preferences', page: () => SignupPreferences()),
        GetPage(
            name: '/signup_preferences_search',
            page: () => SignupPreferencesSearch()),
      ],
      theme: CMPLRTheme.dark(),
    );
  }
}
