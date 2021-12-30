import 'dart:async';
import 'dart:developer';

import '../../utilities/custom_widgets/activity_notification.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../utilities/custom_widgets/activity_filter_row.dart';

import '../../models/pages_model/activity_tab/activity_activity_model.dart'
    as am;

import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Filters and shows blog notifications.
///
/// Handles the Activity sub tab of the activity view.
class ActivityActivityController extends GetxController {
  // Small variables
  int currChosenFilter = 0;
  List<Map<String, List<am.Notification>>> notifications = [];
  List<Widget> notificationWidgets = [];

  // TODO: Convert all rows to CheckboxListTile and SwitchListTile
  // and remove these
  final iconPadding =
      EdgeInsets.only(right: Sizing.blockSize * 4, left: Sizing.blockSize * 2);

  final rowPadding =
      EdgeInsets.symmetric(vertical: Sizing.blockSizeVertical * 2);

  List<String> filterTypes = ['all'];

  var modalSheet;
  var context;
  Timer? fetchTimer;

  /// Fetch some notifications on page creation
  ActivityActivityController() {
    // Fetch the first time we open
    fetchNotifications();

    // Fetch each 10 seconds
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      log('Checking for activity notifications...');
      notifications =
          await am.ActivityActivityModel.getActivityNotifications(filterTypes);
      updateNotifications();
    });
  }

  // FIXME: Update the modalsheet in place
  void filterChosen(context, int newFilterIndex) {
    activityFilters[currChosenFilter]['color'] = Colors.white;
    currChosenFilter = newFilterIndex;
    filterTypes =
        activityFilters[newFilterIndex]['filterTypes'] as List<String>;
    activityFilters[newFilterIndex]['color'] = Colors.lightBlue;
    Get.back();
    update();

    if (activityFilters[newFilterIndex]['rowText'] == 'Custom') {
      final listView = customFilterChosen(context, this);
      update();
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizing.blockSize * 5),
        ),
        builder: (context) => GetBuilder<ActivityActivityController>(
          builder: (controller) => Column(
            children: [
              SizedBox(height: Sizing.blockSizeVertical * 3),
              Container(
                width: Sizing.blockSize * 12,
                height: Sizing.blockSize * 1,
                //TODO: Link this to theme
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Sizing.blockSize))),
              ),
              SizedBox(height: Sizing.blockSizeVertical * 3),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizing.blockSize * 6,
                        vertical: Sizing.blockSizeVertical * 2),
                    child: Text('Filter by',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizing.fontSize * 5)),
                  )),
              Container(
                height: Sizing.blockSize * 0.2,
                //TODO: Link this to theme
                color: Colors.grey[800],
              ),
              Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Sizing.blockSize * 4),
                    child: ListView(
                      shrinkWrap: true,
                      children: listView,
                    )),
              ),
            ],
          ),
        ),
      );
      update();
    }
  }

  /// Traverses the custom filters tree and builds it
  List<Widget> customFilterChosen(context, controller) {
    Get.back();

    final listView = <Widget>[];
    customFilters.forEach((key, value) {
      if (value is Map) {
        // Add the parent option and set it to whatever switch value the user
        // chose
        listView.add(SwitchListTile(
          value: value['chosen'],
          onChanged: (newVal) {
            final valMap = value as Map;
            valMap['chosen'] = newVal;
            controller.update();
          },
          title: Text(
            key,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Sizing.fontSize * 4),
          ),
        ));

        // If chosen, view children too
        if (value['chosen']) {
          final childHorizontalPadding =
              EdgeInsets.symmetric(horizontal: Sizing.blockSize * 8);

          for (final child in value['children']) {
            listView.add(Padding(
              padding: childHorizontalPadding,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      child[0],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizing.fontSize * 4),
                    ),
                    Checkbox(
                      value: child[1],
                      onChanged: (bool? b) {
                        child[1] = b;
                        controller.update();
                      },
                    )
                  ]),
            ));
          }
        }
      } else if (value is bool) {
        listView.add(Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizing.blockSize * 4,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              key,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizing.fontSize * 4),
            ),
            Checkbox(
              value: value,
              onChanged: (bool? b) {
                value = b ?? false;
                controller.update();
              },
            )
          ]),
        ));
      }
    });

    return listView;
  }

  /// Converts the list of filters to widgets
  List<Widget> getFilters(context) {
    final filters = <Widget>[];

    for (var i = 0; i < activityFilters.length; i++) {
      final Map e = activityFilters[i];
      filters.add(ActivityFilterRow(
          icon: e['icon'],
          rowText: e['rowText'],
          onTap: () => filterChosen(context, i),
          iconPadding: iconPadding,
          rowPadding: rowPadding,
          color: e['color']));
    }

    return filters;
  }

  void fetchNotifications() async {
    notifications =
        await am.ActivityActivityModel.getActivityNotifications(filterTypes);
    updateNotifications();
  }

  void updateNotifications() {
    notificationWidgets.clear();

    notifications.forEach((Map<String, List<am.Notification>> notif) {
      final date = notif.keys.first;

      // Add date widget
      notificationWidgets.add(Column(
        children: [
          Padding(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(date),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: Sizing.blockSize * 2,
                vertical: Sizing.blockSizeVertical * 2),
          ),
          Container(
            height: Sizing.blockSize * 0.2,
            //TODO: Link this to theme
            color: Colors.grey[800],
          ),
        ],
      ));

      notif[date]?.forEach((am.Notification notification) {
        notification.type = typeToText[notification.type];
        notificationWidgets.add(ActivityNotification(notification));
      });
    });

    update();
  }

  // Long variables
  /// Holds the various filter options, their back end filter types,
  /// Their current color, their icon, and whether they're the custom
  /// option or not.
  final activityFilters = [
    {
      'icon': Icons.bolt,
      'rowText': 'All Activity',
      'filterTypes': <String>['all'],
      'color': Colors.white
    },
    {
      'icon': Icons.alternate_email,
      'rowText': 'Mentions',
      'filterTypes': <String>['mention_in_reply', 'mention_in_post'],
      'color': Colors.white
    },
    {
      'icon': Icons.loop,
      'rowText': 'Reblogs',
      'filterTypes': <String>['reblog_naked', 'reblog_with_content'],
      'color': Colors.white
    },
    {
      'icon': Icons.chat_bubble,
      'rowText': 'Replies',
      'filterTypes': <String>['reply'],
      'color': Colors.white
    },
    {
      'icon': Icons.tune,
      'rowText': 'Custom',
      'filterTypes': <String>[],
      'color': Colors.white
    }
  ];

  /// Holds the "tree" used in storing and drawing the custom options
  /// menu.
  final customFilters = {
    'Mentions': {
      'chosen': true,
      'children': [
        ['Mentions in a post', true],
        ['Mentions in a reply', true]
      ]
    },
    'Reblogs': {
      'chosen': true,
      'children': [
        ['Reblogs with comment', true],
        ['Reblogs without comment', true]
      ]
    },
    'New followers': true,
    'Likes': true,
    'Replies': true,
    'Asks': {
      'chosen': true,
      'children': [
        ['Received a new ask', true],
        ['Ask answered', true]
      ]
    },
    'Note subscriptions': true,
    'Content Flagging': {
      'chosen': true,
      'children': [
        ['Post flagged', true],
        ['Appeal accepted', true],
        ['Appeal rejected', true],
        ['Spam reported', true],
      ]
    },
    'Your GIF used in a post': true,
    'Posts you missed': true,
    'New group blog members': true
  };

  /// Translates backend notification types to a more meaningful representation.
  final typeToText = {
    'reply': 'replied to your post!',
    'like': 'liked your post!',
    'follow': 'followed you!',
  };
}

class CustomFilters extends StatelessWidget {
  const CustomFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
