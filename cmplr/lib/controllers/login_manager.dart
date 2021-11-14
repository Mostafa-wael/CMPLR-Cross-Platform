import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginManager extends GetxController {
  bool _use_email = false;
  bool _use_google = false;

  void UseEmail() async {
    _use_email = true;
    update();
  }

  void UseGoogle() async {
    _use_google = true;
    update();
  }

}