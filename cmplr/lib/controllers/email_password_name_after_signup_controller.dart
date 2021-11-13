import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../utilities/custom_widgets/custom_widgets.dart';

class EmailPasswordNameAfterSignupController extends GetxController {
  ModelEmailPasswordNameAfterSignup model = ModelEmailPasswordNameAfterSignup();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController();

  bool _passwordHidden = true;
  bool _validInfo = true;
  static const _profileURL = '/profile';
  static const _loginURL = '/login';

  void togglePasswordHide() {
    _passwordHidden = !_passwordHidden;
    update();
  }

  void validateInfo() {
    _validInfo = model.checkEmailPasswordName(
        emailController.text, passwordController.text, nameController.text);
    update();
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

  void toLogin() {
    Get.snackbar('GO TO LOGIN', '');

    // (Tarek) TODO:
    // Go to login page
    // Get.offNamed(_loginURL);
  }

  void toProfile() {
    // (Tarek) TODO:
    // Go to profile
    if (validInfo) {
      Get.snackbar('GO TO PROFILE', '');
      Get.offNamed(_profileURL);
    }
  }
}
