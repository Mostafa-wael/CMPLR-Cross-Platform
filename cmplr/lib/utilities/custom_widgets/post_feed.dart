import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_widgets.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post feed with all its data
class PostFeed extends StatelessWidget {
  var physics;
  var controller;
  var postType = '';
  var tag;
  var prefix;
  var blogName;
  var getTag;

  PostFeed(
      {Key? key,
      postFeedTypePage,
      tag,
      blogName,
      required getTag,
      required prefix})
      : super(key: key) {
    postType = postFeedTypePage ?? '';
    this.tag = tag;
    this.blogName = blogName;
    this.prefix = prefix;
    this.getTag = getTag;

    print('in the view, Post Type is $postType');
    controller = Get.put(PostFeedController(
        postFeedTypeFeed: postType,
        tag: tag,
        prefix: prefix,
        blogName: blogName));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostFeedController>(
        tag: getTag,
        init: PostFeedController(
            postFeedTypeFeed: postType, prefix: prefix, blogName: blogName),
        builder: (controller) => Scaffold(
              body: getBody(context, blogName),
            ));
  }

  Widget getBody(BuildContext context, String? blogName) {
    if (!controller.dataReloaded) {
      return FutureBuilder(
          future: controller.model
              .getNewPosts(postFeedTypeContoller: postType, blogName: blogName),
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
            // if (index >= controller.posts.length) {
            //   return controller.posts[0];
            // } else
            return controller.posts[index];
          }),
    ),
  );
}
