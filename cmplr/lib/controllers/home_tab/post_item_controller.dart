import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';

class PostController extends GetxController with SingleGetTickerProviderMixin {
  void openNotes(int numNotes) {
    Get.toNamed('/notes', arguments: numNotes);
  }

  void reblog() {
    // Get.toNamed('/reblog');
  }

  void openMoreOptions() {
    // Get.toNamed('/more_options');
  }

  void share() {
    // Get.toNamed('/share');
  }

  void lovePost() {}
}
