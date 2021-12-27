import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreateNewTumblrController extends GetxController {
  final nameFieldController = TextEditingController();

  void clearNameField() {
    nameFieldController.clear();
  }
}
