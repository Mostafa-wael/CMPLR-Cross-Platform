import 'dart:developer';

import '../profile_tab/account_settings_view.dart';

import '../../controllers/activity/activity_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './activity_activity.dart';
import './activity_messages.dart';

/// Holds our main tabs for this page: Activity, and Messages
const List<Tab> _tabs = [Tab(text: 'Activity'), Tab(text: 'Messages')];

/// Hodls the views required for the main tabs of this page.
List<Widget> _views = [
  const ActivityActivity(),
  const ActivityMessages(),
];

/// Holds the 2 options for the top right button: refresh, or got to settings
List<DropdownMenuItem<String>> moreItems = <DropdownMenuItem<String>>[
  DropdownMenuItem(
    child: TextButton(
      key: const ValueKey('ActivityRefresh-Refresh'),
      onPressed: () {
        log('Refreshing activity screen');
        final activityActivityController =
            Get.find<ActivityActivityController>();
        activityActivityController.fetchNotifications();

        // TODO: refresh messages

        Get.back();
      },
      child: const Text('Refresh'),
    ),
    value: 'Refresh',
  ),
  DropdownMenuItem(
    child: TextButton(
      key: const ValueKey('ActivityRefresh-Settings'),
      onPressed: () {
        Get.to(const AccountSettingsView());
      },
      child: const Text('Settings'),
    ),
    value: 'Settings',
  ),
];

/// Returns a tab bar with the tabs defined in [_tabs]
TabBar getTabBar(context) {
  return TabBar(
    indicatorWeight: 1,
    indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
    labelColor: Colors.lightBlue[800],
    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    indicatorSize: TabBarIndicatorSize.label,
    unselectedLabelColor: Colors.grey,
    indicatorPadding: const EdgeInsets.all(0),
    tabs: _tabs,
    onTap: (int index) {
      print('Tab $index is tapped');
    },
  );
}

/// The activity screen, it has 2 tabs: activity/notifications, and messages
class ActivityView extends StatelessWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  key: const ValueKey('ActivityRefresh'),
                  items: moreItems,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onChanged: (String? str) {},
                ),
              ),
            )
          ],
          bottom: getTabBar(context),
        ),
        body: TabBarView(children: _views),
      ),
    );
  }
}
