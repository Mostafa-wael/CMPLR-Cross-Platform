import '../views/login_and_sign/signup_mail_name_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Controlls what pages to show in the master page.
class MasterPageController extends GetxController {
  /// Holds the index of the current page
  int currPage = 0;

  int nextIndex = 0;

  /// List of pages to view, corresponds to the bottom buttons.
  List<Widget> pages = [
    const Center(child: Text('Home')),
    const Center(child: Text('Search')),
    const SignupMailName(),
    const SignupMailName(),
  ];

  MasterPageController() {
    if (_getLoggedIn()) logIn();
  }

  /// Changes pages. Checks if the user needs to continue signup.
  ///
  /// If logged in or pages (0,1) are requested, changes index
  /// Otherwise, goes to the continue signup page.
  /// Assumes that the last page is already set as that in the constructor
  void changePage(int index) {
    nextIndex = index;

    // If logged in -> show all pages
    // If home or search (0 or 1), show pages
    if (_getLoggedIn() || [0, 1].any((element) => element == index)) {
      currPage = nextIndex;
    } else {
      // Redirect user to extra signup info
      Get.to(pages.last);
    }
    update();
  }

  /// Helper method to check if the user is logged in or not.
  // If first open -> logged in = null
  // If not logged in -> logged in = false
  // Otherwise -> logged in = true
  // (Tarek) TODO: Maybe cache this? Not sure if get_storage caches it.
  bool _getLoggedIn() => GetStorage().read('logged_in') ?? false;

  /// Replaces the extra signup pages with the proper pages upong login.
  void logIn() {
    pages[2] = const Center(child: Text('Activity'));
    pages[3] = const Center(child: Text('Profile'));
  }

  /// Shows either the activity or profile page depending on where the user
  /// pressed before going to the extra signup page.
  void showActivityOrProfileAfterExtraSignup() {
    Get.back();

    currPage = nextIndex;
    update();
  }
}
