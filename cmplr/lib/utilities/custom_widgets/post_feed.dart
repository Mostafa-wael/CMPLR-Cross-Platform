import './post_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post item with all its data
// ignore: must_be_immutable
class PostFeed extends StatefulWidget {
  const PostFeed({
    Key? key,
  }) : super(key: key);
  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  var controller = Get.put(PostFeedController());
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        addAutomaticKeepAlives: false,
        reverse: true,
        children: controller.getPosts());
  }
}
