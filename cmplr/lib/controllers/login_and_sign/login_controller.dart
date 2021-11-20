import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../views/views.dart';
import '../../utilities/authentication/authentication.dart';

class LoginController extends GetxController {
  // controller for the email text field
  TextEditingController emailController = TextEditingController();

  // controller for the password text field
  TextEditingController passwordController = TextEditingController();

  // whether to hide the password characters in the password text field or not
  bool _hidePassword = true;

  // an instance of the model for login. It handles the validation of email and
  // password
  final ModelEmailPasswordLogin _model = ModelEmailPasswordLogin();

  // whether to show the clear Icon at the end of the text field or not
  bool _showClearIcon = false;

  // tracks the activation of the Login button
  bool _activateLoginButton = false;

  // tracks the activation of the submit password reset request button
  bool _activateSubmitButton = false;

  // tracks whether the email is a valid login email (registered)
  bool _validLoginEmail = false;

  // tracks whether the email/password combination is valid (registered)
  bool _validCombination = false;

  bool get validLoginEmail => _validLoginEmail;

  bool get validCombination => _validCombination;

  bool get showClearIcon => _showClearIcon;

  bool get hidePassword => _hidePassword;

  bool get activateLoginButton => _activateLoginButton;

  bool get activateSubmitButton => _activateSubmitButton;

  /// This method navigates from the first login screen
  /// to the email login screen. It does this by first
  /// navigating to a splash screen for 0.5 seconds then
  /// to the email login screen
  Future<void> loginEmail() async {
    Get.to(
      const LoginEmailSplash(),
      transition: Transition.rightToLeft,
      routeName: '/LoginEmailSplash',
    );
    update();
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.off(
        const LoginEmail(),
        routeName: '/LoginEmail1',
      );
    });
  }

  /// This method navigates from the email login screen to
  /// a screen where the user can click the 'Enter Password' button
  Future<void> continueLoginEmail() async {
    if (emailController.text.isEmpty)
      _showToast('Oops! You forgot to enter your email address!');
    else if (!_model.validateEmail(emailController.text)) {
      {
        // TODO: Replace this will a message below the text field
        _showToast("That email doesn't have a Tumblr account. Sign up now?");
        // Message Below Text field
        // "That email doesn't have a Tumblr account. Sign up now?"
      }
    } else {
      Get.to(const LoginEmailContinue(),
          transition: Transition.noTransition,
          routeName: '/LoginEmailContinue');
    }
    update();
  }

  /// This method navigates to the last screen in the login with email process
  /// where the user can enter their email and password
  Future<void> enterPasswordLoginEmail() async {
    Get.off(
      const LoginEmailPassword(),
      transition: Transition.downToUp,
      routeName: '/LoginEmail3',
    );
    update();
  }

  /// This method handles the backtrack from the
  /// screen with the 'Enter Password' button to
  /// the first screen in the login process
  Future<void> returnFromContinueLoginEmail() async {
    Get.until(
      (route) => Get.currentRoute == '/LoginEmail1',
    );
    update();
  }

  /// This method checks if the current page is the same as the send page
  bool isCurrentPage(String page) {
    return Get.rawRoute!.settings.name == page;
  }

  /// This method handles the email field text changes & updates the widget
  Future<void> emailFieldChanged() async {
    if (emailController.text.isNotEmpty)
      _showClearIcon = true;
    else
      _showClearIcon = false;
    if (isCurrentPage('/LoginEmailContinue')) {
      returnFromContinueLoginEmail();
    }
    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);
    _activateSubmitButton = emailController.text.isNotEmpty;
    _validLoginEmail = _model.validateEmail(emailController.text);
    _validCombination = _model.checkEmailPasswordCombination(
        emailController.text, passwordController.text);
    update();
  }

  /// This method handles the password field text changes & updates the widget
  Future<void> passwordFieldChanged() async {
    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);
    _validCombination = _model.checkEmailPasswordCombination(
        emailController.text, passwordController.text);
    update();
  }

  /// This method handles the validation of the user email/password combination
  /// and if the combination is valid, it navigates to the home page
  Future<void> enterPassword() async {
    if (_validCombination) {
      GetStorage().write('logged_in', true);
      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
    } else {
      // TODO: Replace this will a message below the text field
      _showToast('Incorrect email address or password. Please try again');
    }
    update();
  }

  /// This method navigates to the forgot password screen
  Future<void> forgotPassword() async {
    Get.to(const ForgotPassword(),
        transition: Transition.noTransition, routeName: '/ForgotPassword');
    update();
  }

  /// This method navigates to post forgot password screen where
  /// the user is informed that an email was sent to them
  Future<void> sendResetEmail() async {
    if (!_model.validateEmail(emailController.text)) {
      {
        _showToast(
            'This doesn\'t look like an email address... check it again?');
        // Message Below Text field
        // "That email doesn't have a Tumblr account. Sign up now?"
      }
    } else {
      // TODO: Send email
      Get.off(
        const PostForgotPassword(),
        transition: Transition.noTransition,
        routeName: '/PostForgotPassword',
      );
    }
  }

  /// This method handles logging in with google
  Future<void> loginGoogle(BuildContext context) async {
    await Authentication.initializeFirebase();
    User? user;
    user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      GetStorage().write('logged_in', true);
      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
        routeName: '/MasterPage',
        arguments: user,
      );
    } else {
      _showToast('Failed to Login, please try again');
    }
  }

  /// This method toggles the visibility of the password text field
  Future<void> viewHidePassword() async {
    _hidePassword = !_hidePassword;
    update();
  }

  /// This method handles navigating back from the post forgot password screen
  /// to the screen where the user enters their email/password combination to
  /// log in
  Future<void> returnFromSendResetEmail() async {
    Get.until((route) => Get.currentRoute == '/LoginEmail3');
    update();
  }
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
