import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final _ageController = TextEditingController();
  int _nextButtonColor = 0xFF015887;
  bool _showClearButton = false;
  bool _isLoading = false;

  TextEditingController get ageController {
    return _ageController;
  }

  int get nextButtonColor {
    return _nextButtonColor;
  }

  bool get showClearButton {
    return _showClearButton;
  }

  bool get isLoading {
    return _isLoading;
  }

  void ageFieldChanged() {
    if (_ageController.text == '') {
      _showClearButton = false;
      _nextButtonColor = 0xFF015887;
    } else {
      _showClearButton = true;
      final age = int.parse(_ageController.text);
      if (age == 0 || age > 130) {
        _nextButtonColor = 0xFF015887;
      } else {
        _nextButtonColor = 0xFF00B7FE;
      }
    }
    update();
  }

  void nextButtonPressed() async {
    _isLoading = true;
    update();

    await Future.delayed(const Duration(seconds: 3));

    if (int.parse(ageController.text) < 13) {
    } else {}

    _isLoading = false;
    update();
  }
}
