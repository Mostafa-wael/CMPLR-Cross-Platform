import '../../models/pages_model/home_tab/reblog_model.dart';
import '../../utilities/custom_widgets/write_post_or_reblog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';

/// the view of the rebolg
class ReblogView extends StatelessWidget {
  const ReblogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WritePostOrReblog(const ReblogModel(), Get.find<ReblogController>());
  }
}
