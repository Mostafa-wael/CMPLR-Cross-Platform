import '../profile_tab/account_settings_view.dart';

import '../../controllers/activity/activity_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../routes.dart';
import './activity_activity.dart';
import './activity_messages.dart';
import '../../utilities/user.dart';

const List<Tab> _tabs = [Tab(text: 'Activity'), Tab(text: 'Messages')];
List<Widget> _views = [
  const ActivityActivity(),
  const ActivityMessages(),
];

List<DropdownMenuItem<String>> moreItems = <DropdownMenuItem<String>>[
  DropdownMenuItem(
    child: TextButton(
      onPressed: () {
        final activityActivityController =
            Get.find<ActivityActivityController>();
        activityActivityController.fetchNotifications();

        // TODO: refresh messages
      },
      child: const Text('Refresh'),
    ),
    value: 'Refresh',
  ),
  DropdownMenuItem(
    child: TextButton(
      onPressed: () {
        Get.to(const AccountSettingsView());
      },
      child: const Text('Settings'),
    ),
    value: 'Settings',
  ),
];

/// The activity screen, it has 2 tabs: activity, and messages
class ActivityView extends StatelessWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
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
