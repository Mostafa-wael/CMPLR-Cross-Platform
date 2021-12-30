import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../views/profile_tab/profile_view.dart';
import '../../flags.dart';
import '../sizing/sizing.dart';
import '../../views/blog/screens/visitor_blog.dart';
import '../../models/pages_model/activity_tab/activity_activity_model.dart'
    as am;

import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// The main widget used to show notifications in [ActivityActivityView]
class ActivityNotification extends StatelessWidget {
  /// Notification data used to construct the widget.
  /// Obtained from mock data or the backend
  final am.Notification notif;

  final testIndex;

  const ActivityNotification(this.notif, this.testIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizing.blockSize * 2,
          vertical: Sizing.blockSizeVertical * 2),
      child: Row(
        children: [
          GestureDetector(
            key: ValueKey('ActivityNotificationsFromBlog$testIndex'),
            child: Padding(
              padding: EdgeInsets.all(Sizing.blockSize),
              child: SizedBox(
                child: FadeInImage.assetNetwork(
                    placeholder: placeHolderImgPath,
                    image: notif.fromBlogAvatar),
                width: Sizing.blockSize * 10,
                height: Sizing.blockSize * 10,
              ),
            ),
            onTap: goToBlog,
          ),
          GestureDetector(
            key: ValueKey('ActivityNotificationsMessage$testIndex'),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizing.blockSize * 2,
                  vertical: Sizing.blockSizeVertical * 2),
              child: Expanded(
                child: Text(
                  [notif.fromBlogName, notif.type].join(' '),
                  style: TextStyle(
                    color: Get.theme.textTheme.bodyText1?.color,
                  ),
                ),
              ),
            ),
            onTap: goToYourOwnProfile,
          ),
        ],
      ),
    );
  }

  // Helper functions
  void goToBlog() {
    Get.to(VisitorBlog(
      blogId: notif.fromBlogId.runtimeType == int
          ? notif.fromBlogId.toString()
          : notif.fromBlogId,
      blogName: notif.fromBlogName,
    ));
  }

  void goToYourOwnProfile() {
    Get.to(const ProfileView());
  }
}
