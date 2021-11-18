import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../views/login_and_sign/android_views.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IntroController extends GetxController {
  Future<void> signIn() async {
    Get.to(
      const Login(),
      transition: Transition.downToUp,
    );
    update();
  }

  Future<void> signUp() async {
    Get.to(
      const SignupAge(),
      transition: Transition.downToUp,
    );
    update();
  }
}
