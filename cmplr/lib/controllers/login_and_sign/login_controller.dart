import '../../utilities/authentication/authentication.dart';

import '../../models/persistent_storage_api.dart';

import '../../utilities/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../views/views.dart';

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

  bool get validLoginEmail => _validLoginEmail;

  bool get showClearIcon => _showClearIcon;

  bool get hidePassword => _hidePassword;

  bool get activateLoginButton => _activateLoginButton;

  bool get activateSubmitButton => _activateSubmitButton;

  List errors = [];

  /// This method navigates from the first login screen
  /// to the email login screen. It does this by first
  /// navigating to a splash screen for 0.5 seconds then
  /// to the email login screen
  Future<void> loginEmail() async {
    Get.to(
      const LoginEmailSplash(),
      transition: Transition.rightToLeft,
      routeName: Routes.loginEmailSplash,
    );
    update();

    Future.delayed(const Duration(milliseconds: 500), () {
      Get.off(
        const LoginEmail(),
        routeName: Routes.loginEmail,
      );
    });
  }

  /// This method navigates from the email login screen to
  /// a screen where the user can click the 'Enter Password' button
  Future<bool> tryLogin() async {
    var successful = Future.value(false);

    errors = await _model.checkEmailPasswordCombination(
        emailController.text, passwordController.text);
    if (errors.isEmpty) {
      // Log in
      PersistentStorage.changeLoggedIn(true);

      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
      successful = Future.value(true);
    }

    update();
    return successful;
  }

  /// This method navigates to the last screen in the login with email process
  /// where the user can enter their email and password
  Future<void> enterPasswordLoginEmail() async {
    if (emailController.text.isEmpty) {
      _showToast('Oops! You forgot to enter your email address!');
    } else {
      Get.off(
        const LoginEmailPassword(),
        transition: Transition.downToUp,
        routeName: Routes.loginEmailPassword,
      );
      update();
    }
  }

  // This method navigates from the email login screen to
  /// a screen where the user can click the 'Enter Password' button
  Future<void> continueLoginEmail() async {
    Get.toNamed(Routes.loginEmailContinue);
  }

  /// This method handles the backtrack from the
  /// screen with the 'Enter Password' button to
  /// the first screen in the login process
  Future<void> returnFromContinueLoginEmail() async {
    Get.until(
      (route) => Get.currentRoute == Routes.loginEmail,
    );
    update();
  }

  /// This method checks if the current page is the same as the send page
  bool isCurrentPage(String page) {
    return Get.rawRoute!.settings.name == page;
  }

  /// This method handles the email field text changes & updates the widget
  Future<void> emailFieldChanged() async {
    if (Get.rawRoute != null && isCurrentPage(Routes.loginEmailContinue)) {
      returnFromContinueLoginEmail();
    }

    if (emailController.text.isNotEmpty)
      _showClearIcon = true;
    else
      _showClearIcon = false;

    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);

    _activateSubmitButton = emailController.text.isNotEmpty;
    _validLoginEmail = validateEmail(emailController.text);

    update();
  }

  /// This method handles the password field text changes & updates the widget
  Future<void> passwordFieldChanged() async {
    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);

    update();
  }

  /// This method navigates to the forgot password screen
  Future<void> forgotPassword() async {
    Get.to(const ForgotPassword(),
        transition: Transition.noTransition, routeName: Routes.forgotPassword);
    update();
  }

  /// This method navigates to post forgot password screen where
  /// the user is informed that an email was sent to them
  Future<void> sendResetEmail() async {
    if (!validateEmail(emailController.text)) {
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
        routeName: Routes.postForgotPassword,
      );
    }
  }

  /// This method handles logging in with google
  Future<void> loginGoogle(BuildContext context) async {
    await Authentication.initializeFirebase();
    User? user;
    user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      PersistentStorage.changeLoggedIn(true);
      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
        routeName: Routes.masterPage,
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
    // (Tarek) TODO: Make sure this works
    Get.until((route) => Get.currentRoute == Routes.loginEmailPassword);
    update();
  }

  /// This method handles the validation of the user email/password combination
  /// and if the combination is valid, it navigates to the home page
  // Future<void> enterPassword() async {
  //   if () {
  //     GetStorage().write('logged_in', true);
  //     Get.offAll(
  //       const MasterPage(),
  //       transition: Transition.rightToLeft,
  //     );
  //   } else {
  //     // TODO: Replace this will a message below the text field
  //     _showToast('Incorrect email address or password. Please try again');
  //   }
  //   update();
  // }
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
