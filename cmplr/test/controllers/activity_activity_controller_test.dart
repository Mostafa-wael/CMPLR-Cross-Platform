import 'package:cmplr/controllers/activity/activity_activity_controller.dart';
import 'package:cmplr/models/pages_model/activity_tab/activity_activity_model.dart';
import 'package:cmplr/utilities/sizing/sizing.dart';
import 'package:cmplr/views/utilities/activity_notification.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/pages_model/activity_tab/activity_activity_model.dart'
    as am;
import 'package:flutter/material.dart'
    show MediaQuery, Container, MediaQueryData, Column;

// activityController.notifications (ac.n for short) is a list of maps
// ac.n[0] -> notif_group_date : [Notification, Notification, etc...]
// ac.n[1] -> notif_group_date : [Notification, Notification, etc...]

void main() {
  testWidgets('ActivityActivity controller test', (tester) async {
    final mq = MediaQuery(
      child: Container(),
      data: const MediaQueryData(),
    );

    Sizing.width = mq.data.size.width;
    Sizing.height = mq.data.size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    final activityActivityController = ActivityActivityController();

    await tester.runAsync(() async {
      activityActivityController.fetchNotifications();

      tester.pump(const Duration(seconds: 2));

      assert(activityActivityController.notifications.length > 0);

      // Map. Key is String. Value is a list of Notifications
      final firstNotifGroupData =
          activityActivityController.notifications.first;

      assert(firstNotifGroupData.keys.first.runtimeType == String);

      final firstNotifData = firstNotifGroupData.values.first.first;
      assert(firstNotifData.runtimeType == Notification);

      assert(activityActivityController.notificationWidgets.length > 0);

      final firstDateWidget =
          activityActivityController.notificationWidgets.first;

      final firstNotifWidget =
          activityActivityController.notificationWidgets[1];

      assert(activityActivityController.notificationWidgets.length > 0);
      assert(firstDateWidget.runtimeType == Column);
      assert(firstNotifWidget.runtimeType == ActivityNotification);
    });
  });
}
