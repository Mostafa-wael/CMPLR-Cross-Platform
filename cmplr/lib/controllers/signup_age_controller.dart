import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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

  // this handles the change of the age text field
  void ageFieldChanged() {
    if (_ageController.text == '') {
      // empty text field
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

  void nextButtonPressed() async {
    if (_nextButtonActivated) {
      _isLoading = true;
      _focusNode.unfocus();
      update();

      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      update();
      if (int.parse(ageController.text) < 13) {
        _showToast('Too young!');
      } else {
        Get.offNamed('/signup_preferences');
      }
    }
  }

  void closeAgeScreen() {
    Get.back();
  }

  // this shows toast if the age is inappropriate
  void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53));
}
