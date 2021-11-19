import '../../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../views/views.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> signUpEmail() async {
    Get.to(
      const SignupAge(),
      transition: Transition.rightToLeft,
    );
    update();
  }

  Future<void> signUpGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) _showToast('Sign in failed');
    // TODO: send googleSignInAccount to the user model
    Get.offAll(
      const MasterPage(),
      transition: Transition.rightToLeft,
    );
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
