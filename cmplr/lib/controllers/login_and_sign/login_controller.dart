import '../../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../views/views.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _hidePassword = true;
  final ModelEmailPasswordLogin _model = ModelEmailPasswordLogin();

  bool get hidePassword => _hidePassword;

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
        routeName: 'LoginEmail1',
      );
    });
  }

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
      Get.to(
        const LoginEmailContinue(),
        transition: Transition.noTransition,
      );
    }
    update();
  }

  Future<void> enterPasswordLoginEmail() async {
    Get.off(
      const LoginEmailPassword(),
      transition: Transition.downToUp,
      routeName: '/LoginEmail3',
    );
    update();
  }

  Future<void> returnFromContinueLoginEmail() async {
    Get.until(
      (route) => Get.currentRoute == '/LoginEmail1',
    );
    update();
  }

  bool isCurrentPage(String page) {
    return Get.rawRoute!.settings.name == page;
  }

  Future<void> emailFieldChanged() async {
    update();
  }

  Future<void> sendResetEmail() async {
    if (!_model.validateEmail(emailController.text)) {
      {
        _showToast(
            'This doesn\'t look like an email address... check it again?');
        // Message Below Text field
        // "That email doesn't have a Tumblr account. Sign up now?"
      }
    }
     else {
       // TODO: Send email
      Get.off(
        const PostForgotPassword(),
        transition: Transition.noTransition,
        routeName: '/PostForgotPassword',
      );
    }
  }

  Future<void> enterPassword() async {
    if (_model.checkEmailPasswordCombination(
        emailController.text, passwordController.text))
      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
    else {
      // TODO: Replace this will a message below the text field
      _showToast('Incorrect email address or password. Please try again');
    }
    update();
  }

  Future<void> forgotPassword() async {
    Get.to(const ForgotPassword(),
        transition: Transition.noTransition, routeName: '/ForgotPassword');
    update();
  }

  Future<void> loginGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) _showToast('Sign in failed');
    // TODO: use model.validateGoogleAccount(googleSignInAccount);
    Get.offAll(
      const MasterPage(),
      transition: Transition.rightToLeft,
    );
    update();
  }

  Future<void> viewHidePassword() async {
    _hidePassword = !_hidePassword;
    update();
  }

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
