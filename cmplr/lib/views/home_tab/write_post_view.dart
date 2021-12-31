import '../../models/pages_model/home_tab/write_post_model.dart';
import '../../utilities/custom_widgets/write_post_or_reblog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../controllers/controllers.dart';

/// write post view
class WritePost extends StatelessWidget {
  const WritePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WritePostOrReblog(
        const WritePostModel(), Get.find<WritePostController>());
  }
}
