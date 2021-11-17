import '../views/android_views/email_password_name_after_signup.dart';
import '../views/android_views/intro_screen.dart';
import '../views/android_views/master_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MasterPageManager extends GetxController {
  static GetStorage? storage;
  int currPage = 0;

  List<Widget> pages;

  MasterPageManager({required List<Widget> this.pages}) {
    GetStorage.init();
    storage = GetStorage();

    if (storage?.read('logged_in') ?? true) {
      pages[2] = const EmailPasswordNameAfterSignup();
      pages[3] = const EmailPasswordNameAfterSignup();
    }
  }

  void changePage(int index) {
    if ([0, 1].any((element) => element == index))
      currPage = index;
    else {
      Get.to(pages[3]);
    }
    update();
  }

  Widget _firstPage() {
    if (storage?.read('logged_in') ?? true)
      return const IntroScreen();
    else
      return const MasterPage();
  }
}
