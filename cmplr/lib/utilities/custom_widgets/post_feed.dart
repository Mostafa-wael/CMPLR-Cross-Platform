import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post feed with all its data
class PostFeed extends StatefulWidget {
  const PostFeed({
    Key? key,
  }) : super(key: key);
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  final _scrollController = ScrollController();
  var controller = Get.put(PostFeedController());

  @override
  void initState() {
    super.initState();

    // Setup the listener to indicate if we reached the top of the page.
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print("You're at the bottom, do nothing");
        } else {
          print("You're at the top, get new feeds");
          controller.updatePosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.initialPosts();
    return GetBuilder<PostFeedController>(
        // USe satck to be able to add the laod indicator on the top of the page
        builder: (controller) => Stack(children: [
              controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
              ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  reverse: true, // so that the new posts are added on the top
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return controller.posts[index];
                  }),
            ]));
  }
}
