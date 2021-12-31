import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controllers/controllers.dart';

import '../utilities/utility_views.dart';
import 'package:flutter/material.dart';

/// Try these posts view on the expolre
class TryThesePosts extends StatelessWidget {
  TryThesePosts({Key? key}) : super(key: key);

  var controller = Get.put(TryThesePostsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            controller.closeTryThesePosts();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Recommended for you',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: PostFeed(
        getTag: 'TryThesePosts',
        postFeedTypePage: '/recommended/posts',
        prefix: 'TryThesePosts',
      ),
    );
  }
}
