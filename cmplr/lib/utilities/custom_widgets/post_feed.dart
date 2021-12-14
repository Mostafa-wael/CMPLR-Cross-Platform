import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/controllers.dart';

/// This widget represents the post feed with all its data
class PostFeed extends StatelessWidget {
  PostFeed({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(PostFeedController());

  @override
  Widget build(BuildContext context) {
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

// This preserves the scroll state of the list view,
// It is used due to this issue in Getx: https://github.com/jonataslaw/getx/issues/822
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);
  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  const RefreshWidget({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);
  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: widget.child, onRefresh: widget.onRefresh);
  }
}

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
