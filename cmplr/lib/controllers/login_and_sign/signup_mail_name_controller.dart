import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
import '../master_page_controller.dart';

// (Tarek) TODO: maybe rename this to ExtraSignup?

/// Controlls the extra signup process
class EmailPasswordNameAfterSignupController extends GetxController {
  MasterPageController? masterPageController;

  ModelEmailPasswordNameAfterSignup model = ModelEmailPasswordNameAfterSignup();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController();

  bool _passwordHidden = true;
  bool _validInfo = true;
  static const _loginURL = '/login';

  /// Gets a reference to the master page controller
  EmailPasswordNameAfterSignupController() {
    masterPageController = Get.find<MasterPageController>();
  }

  void togglePasswordHide() {
    _passwordHidden = !_passwordHidden;
    update();
  }

  /// Checks whether the email AND username don't already exist.
  Future<bool> validateInfo() {
    return model
        .checkEmailPasswordName(
            emailController.text, passwordController.text, nameController.text)
        .then((response) {
      _validInfo = response;
      if (_validInfo) toActivityOrProfile();
      update();
      return response;
    });
  }

  bool get passwordHidden => _passwordHidden;
  bool get validInfo => _validInfo;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Error();
    }
  }

  /// Removes all previous pages, replacing them with the login page.
  void toLogin() {
    // Get.snackbar('GO TO LOGIN', '');

    // (Tarek) TODO:
    // Go to login page
    Get.offAllNamed(_loginURL);
  }

  /// After the extra signup, routes the user to the page they were originally
  /// intending on visiting. Sets [logged_in] to true in get_storage.
  void toActivityOrProfile() {
    // (Tarek) TODO:
    // Go to profile
    // Get.snackbar('GO TO PROFILE/ACTIVITY', '');

    masterPageController?.logIn();
    masterPageController?.showActivityOrProfileAfterExtraSignup();

    GetStorage().write('logged_in', true);
  }
}
