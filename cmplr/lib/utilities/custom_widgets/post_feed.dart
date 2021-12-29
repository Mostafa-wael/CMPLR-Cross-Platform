import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_widgets.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post feed with all its data
class PostFeed extends StatelessWidget {
  var physics;
  var controller;
  var postType = '';
  PostFeed({Key? key, postFeedTypePage, tag}) : super(key: key) {
    postType = postFeedTypePage ?? '';
    print('in the view, Post Type is $postType');
    controller =
        Get.put(PostFeedController(postFeedTypeFeed: postType, tag: tag));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostFeedController>(
        init: PostFeedController(postFeedTypeFeed: postType),
        builder: (controller) => getBody(context));
  }

  Widget getBody(BuildContext context) {
    if (!controller.dataReloaded) {
      return FutureBuilder(
          future: controller.model.getNewPosts(postFeedTypeContoller: postType),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              controller.posts = snapshot.data ?? <PostItem>[];
              return buildMainView(controller);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          });
    } else {
      return buildMainView(controller);
    }
  }
}
////////////////////////////////////////////////////////////////

Widget buildMainView(PostFeedController controller) {
  return KeepAliveWrapper(
    child: RefreshWidget(
      onRefresh: () {
        return controller.updatePosts();
      },
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return controller.posts[index];
          }),
    ),
  );
}
