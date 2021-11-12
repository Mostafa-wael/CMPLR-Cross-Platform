import 'package:cmplr/cmplr_theme.dart';
import 'package:cmplr/views/android_views/email_password_name_after_signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const Scaffold(
        //   body: Center(
        //       child: Text(
        //     'CMPLR',
        //     style: TextStyle(fontSize: 25),
        //   )),
        // ),
        home: CheckView(),
        theme: CMPLRTheme.dark());
  }

  Widget CheckView() {
    return EmailPasswordNameAfterSignup();
  }
}
