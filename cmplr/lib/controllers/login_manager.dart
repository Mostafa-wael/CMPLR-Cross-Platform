import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../views/android_views/android_views.dart';

class LoginManager extends GetxController {
  bool _use_email = false;
  bool _use_google = false;

  Future<void> UseEmail() async {
    _use_email = true;
    Get.to(const LoginEmail());
    update();
  }

  void UseGoogle() {
    _use_google = true;
    update();
  }

}