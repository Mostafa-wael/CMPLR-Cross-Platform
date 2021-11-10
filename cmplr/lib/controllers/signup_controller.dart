import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final _ageController = TextEditingController();
  final _focusNode = FocusNode();
  int _nextButtonColor = 0xFF015887;
  bool _nextButtonActivated = false;
  bool _showClearButton = false;
  bool _isLoading = false;

  TextEditingController get ageController {
    return _ageController;
  }

  int get nextButtonColor {
    return _nextButtonColor;
  }

  bool get nextButtonActivated {
    return _nextButtonActivated;
  }

  bool get showClearButton {
    return _showClearButton;
  }

  bool get isLoading {
    return _isLoading;
  }

  FocusNode get focusNode {
    return _focusNode;
  }

  void ageFieldChanged() {
    if (_ageController.text == '') {
      _showClearButton = false;
      _nextButtonColor = 0xFF015887;
      _nextButtonActivated = false;
    } else {
      _showClearButton = true;
      final age = int.parse(_ageController.text);
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

      if (int.parse(ageController.text) < 13) {
        _showToast('Too young!');
      } else {
        _showToast('Success');
      }
      _isLoading = false;
      update();
    }
  }

  void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Color(0xFF4E4F53));
}
