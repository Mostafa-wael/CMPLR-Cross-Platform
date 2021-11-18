import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // the color of 'submit' button (it changes with the input of the text field)
  int _submitButtonColor = 0xFF015887;

  // determine whether the 'submit' button is activated or not
  bool _submitButtonActivated = false;

  // determines whether the screen is loading or not
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  bool _showInvalidEmailError = false;

  // getters for class attributes
  int get nextButtonColor => _submitButtonColor;

  bool get nextButtonActivated => _submitButtonActivated;

  bool get isLoading => _isLoading;

  TextEditingController get emailController => _emailController;

  bool get showInvalidEmailError => _showInvalidEmailError;

  @override
  void onInit() {
    _emailController.text = Get.arguments;
    emailFieldChanged();
    super.onInit();
  }

  Future<void> emailFieldChanged() async {
    if (_emailController.text == '') {
      _submitButtonColor = 0xFF015887;
      _submitButtonActivated = false;
    } else {
      _submitButtonColor = 0xFF00B7FE;
      _submitButtonActivated = true;
    }
    update();
  }

  void submitButtonPressed() async {
    if (_submitButtonActivated) {
      if (!_emailController.text.isEmail) {
        _showInvalidEmailError = true;
        update();
      } else {
        _isLoading = true;
        update();

        //TODO: communicate with the API instead of delay
        await Future.delayed(const Duration(seconds: 1));

        _isLoading = false;
        update();
      }
    }
  }

  void closeForgotPassword() {
    Get.back();
  }
}
