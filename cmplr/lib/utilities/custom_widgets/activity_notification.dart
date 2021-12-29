import '../../views/blog/screens/visitor_blog.dart';
import 'package:get/get.dart';

import '../../flags.dart';
import '../../models/pages_model/activity_tab/activity_activity_model.dart'
    as am;
import '../../routes.dart';
import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class ActivityNotification extends StatelessWidget {
  final am.Notification notif;
  const ActivityNotification(this.notif, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizing.blockSize, vertical: Sizing.blockSizeVertical),
      child: Row(
        children: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(Sizing.blockSize),
              child: SizedBox(
                child: FadeInImage.assetNetwork(
                    placeholder: placeHolderImgPath,
                    image: notif.fromBlogAvatar),
                width: Sizing.blockSize * 5,
                height: Sizing.blockSize,
              ),
            ),
            onTap: goToBlog,
          ),
          GestureDetector(
            child: Expanded(
              child: Text(notif.fromBlogName + notif.type + notif),
            ),
            onTap: goToYourOwnProfile,
          ),
        ],
      ),
    );
  }

  void goToBlog() {
    Get.to(VisitorBlog(blogId: notif.fromBlogId));
  }

  void goToYourOwnProfile() {
    Get.toNamed(Routes.profile);
  }
}
