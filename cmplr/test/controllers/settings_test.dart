import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/utilities/sizing/sizing.dart';
import 'package:cmplr/utilities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Edit profile test', (tester) async {
    Get.testMode = true;
    await User.prepareMockData();
    final controller = ProfileController();
    await tester.pump(const Duration(seconds: 2));
    assert(controller.allowSubmissions == false);
    assert(controller.ask == false);
    assert(controller.useMedia == false);
    assert(controller.topPosts == false);
    assert(controller.optimizeVideo == false);
    assert(controller.showUploadProg == false);
    assert(controller.disableDoubleTapToLike == false);
    controller.toggleDisableDoubleTapToLike();
    controller.toggleOptimizeVids();
    await tester.pump(const Duration(seconds: 2));
    assert(controller.disableDoubleTapToLike == true);
    assert(controller.optimizeVideo == true);
  });
}
