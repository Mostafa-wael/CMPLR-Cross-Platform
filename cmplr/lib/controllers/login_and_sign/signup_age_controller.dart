import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes.dart';

class SignupAgeController extends GetxController {
  // controller for the age text field
  final _ageController = TextEditingController();

  // focus controller for the age text field
  final _focusNode = FocusNode();

  // the color of 'next' button (it changes with the input of the text field)
  int _nextButtonColor = 0xFF015887;

  // determine whether the 'next' button is activated or not
  bool _nextButtonActivated = false;

  // the button which clears the age text field
  bool _showClearButton = false;

  // determines whether the screen is loading or not
  bool _isLoading = false;

  // getters for class attributes
  TextEditingController get ageController => _ageController;

  int get nextButtonColor => _nextButtonColor;

  bool get nextButtonActivated => _nextButtonActivated;

  bool get showClearButton => _showClearButton;

  bool get isLoading => _isLoading;

  FocusNode get focusNode => _focusNode;

  /// This function is called whenever the age changes,
  /// It handles the different scenarios of the age text field
  void ageFieldChanged() {
    // empty text field
    if (_ageController.text == '') {
      _showClearButton = false;
      _nextButtonColor = 0xFF015887;
      _nextButtonActivated = false;
    } else {
      _showClearButton = true;
      final age = int.parse(_ageController.text);

      // age constraints
      if (age == 0 || age > 130) {
        _nextButtonColor = 0xFF015887;
        _nextButtonActivated = false;
      } else {
        _nextButtonColor = 0xFF00B7FE;
        _nextButtonActivated = true;
      }
    }
    update();
  }

  /// This is called when the user presses on 'next' button, it sets the screen
  /// status to be 'loading' so that the progress indicator appears and if the
  /// entered age is appropriate, it redirects the user to the next screen
  void nextButtonPressed() async {
    if (_nextButtonActivated) {
      _isLoading = true;
      _focusNode.unfocus();
      update();

      //TODO: communicate with the API instead of delay
      await Future.delayed(const Duration(seconds: 1));

      if (int.parse(ageController.text) < 13) {
        _isLoading = false;
        _showToast('Minor hiccup. Try again.');
      } else {
        GetStorage().write('age', ageController.text);
        Get.offNamed(Routes.signupPreferencesScreen);
      }
      update();
    }
  }

  void closeAgeScreen() {
    Get.back();
  }

  /// This redirects to the privacy policy and terms of service URLs
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Error();
    }
  }

  /// This function shows toast if the age entered by the user is inappropriate
  void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53));
}
