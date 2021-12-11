import '../../models/persistent_storage_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
import '../../routes.dart';
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
  bool _fieldsFilled = false;
  static const _loginURL = Routes.login;

  List? errors;

  Widget getDoneButton(context) {
    if (_fieldsFilled)
      return Text(
        'Done',
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      );
    else
      return const Text(
        'Done',
        style: TextStyle(color: Colors.white),
      );
  }

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
    if (_fieldsFilled)
      return model
          .checkEmailPasswordName(emailController.text, passwordController.text,
              nameController.text)
          .then((errorList) {
        _validInfo = errorList.isEmpty;
        errors = errorList;
        if (_validInfo) toActivityOrProfile();
        update();
        return _validInfo;
      });
    else {
      _validInfo = false;
      update();
      return Future.value(false);
    }
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

    PersistentStorage.changeLoggedIn(true);
  }

  // Called whenever the email, password, or name fields change in
  // the extra signup screen.
  void fieldChanged(String str) {
    _fieldsFilled = !emailController.text.isEmpty &&
        !passwordController.text.isEmpty &&
        !nameController.text.isEmpty;
    update();
  }
}
