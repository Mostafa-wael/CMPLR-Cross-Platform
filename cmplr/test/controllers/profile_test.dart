import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/utilities/sizing/sizing.dart';
import 'package:cmplr/utilities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Profile test', (tester) async {
    Get.testMode = true;
    await User.prepareMockData();
    final controller = ProfileController();
    await tester.pump(const Duration(seconds: 2));
    assert(controller.blogInfo == null);
    controller.getBlogInfo();
    await tester.pump(const Duration(seconds: 2));
    assert(controller.blogName == 'yousef');
    assert(controller.blogTitle == 'untitled');
    assert(controller.blogAvatar ==
        'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png');
    assert(controller.blogAvatarShape == 'circle');
    assert(controller.url == 'http://cmplr/1/info');
    assert(controller.description == 'Test');
    assert(controller.headerImage == 'https://via.placeholder.com/150');
    assert(controller.backgroundColor == const Color(0xff000000));
  });
}
