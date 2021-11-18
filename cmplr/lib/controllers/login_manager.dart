import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../views/android_views/android_views.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginManager extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> useEmail() async {
    Get.to(
      const LoginEmailSplash(),
      transition: Transition.rightToLeft,
    );
    update();
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.off(
        const LoginEmail1(),
      );
    });
  }

  Future<void> emailFieldChanged() async {
    update();
  }

  Future<void> validateEmail() async {
    if (!emailController.text.isEmpty && emailController.text.isEmail) {
      Get.to(
        const LoginEmail2(),
        transition: Transition.noTransition,
      );
    } else if (emailController.text.isEmpty)
      _showToast('Oops! You forgot to enter your email address!');
    else {
      // Message Below Text field
      // "That email doesn't have a Tumblr account. Sign up now?"
    }
    update();
  }

  Future<void> enterPassword() async {
    Get.to(const LoginPassword());
    update();
  }

  Future<void> validatePassword() async {}

  Future<void> useGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    update();
  }

  void forgotPassword() {
    Get.toNamed('/forgot_password', arguments: emailController.text);
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
