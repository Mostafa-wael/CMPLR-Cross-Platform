import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/getwidget.dart';

import 'custom_widgets.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post feed with all its data
class PostFeed extends StatelessWidget {
  var physics;
  PostFeed({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(PostFeedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostFeedController>(
        init: PostFeedController(), builder: (controller) => getBody(context));
  }

  Widget getBody(BuildContext context) {
    if (!controller.dataReloaded) {
      return FutureBuilder(
          future: controller.model.getNewPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              controller.posts = snapshot.data ?? [];
              print('view');
              print(controller.posts.length);
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
