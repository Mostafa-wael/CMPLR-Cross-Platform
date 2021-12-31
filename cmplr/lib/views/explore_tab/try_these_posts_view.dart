import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../controllers/controllers.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

/// Try these posts view on the expolre
class TryThesePosts extends StatelessWidget {
  TryThesePosts({Key? key}) : super(key: key);

  var controller = Get.put(TryThesePostsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.closeTryThesePosts();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Recommended for you',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
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
