import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../utilities/custom_widgets/activity_filter_row.dart';

import '../../models/pages_model/activity_tab/activity_activity_model.dart';

import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Filters and shows blog notifications.
///
/// Handles the Activity sub tab of the activity view.
class ActivityActivityController extends GetxController {
  // Small variables
  int currChosenFilter = 0;
  final iconPadding =
      EdgeInsets.only(right: Sizing.blockSize * 4, left: Sizing.blockSize * 2);
  final rowPadding =
      EdgeInsets.symmetric(vertical: Sizing.blockSizeVertical * 2);

  List<String> filterTypes = [];

  void filterChosen(int newFilterIndex) {
    activityFilters[currChosenFilter]['color'] = Colors.white;
    currChosenFilter = newFilterIndex;
    filterTypes =
        activityFilters[newFilterIndex]['filterTypes'] as List<String>;
    activityFilters[newFilterIndex]['color'] = Colors.lightBlue;
    Get.back();
    update();
  }

  void customFilterChosen(context) {
    Get.back();

    final listView = <Widget>[];

    customFilters.forEach((key, value) {
      if (value is Map) {
        value = value as Map;

        listView.add(Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizing.blockSize * 4,
              vertical: Sizing.blockSizeVertical * 1),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Switch(
              value: value['chosen'],
              onChanged: (bool b) {},
            )
          ]),
        ));
      } else if (value is bool) {
        listView.add(Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizing.blockSize * 4,
              vertical: Sizing.blockSizeVertical * 1),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Checkbox(
              value: value,
              onChanged: (bool? b) {},
            )
          ]),
        ));
      }
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizing.blockSize * 5),
      ),
      builder: (context) => Column(
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
          ListView.builder(
              itemCount: listView.length,
              itemBuilder: (BuildContext context, int index) => listView[index])
        ],
      ),
    );

    // print(filterTypes);
    print('KAK');
  }

  void fetchNotifications() async {
    ActivityActivityModel.getActivityNotifications(filterTypes);
  }

  List<Widget> getFilters(context) {
    final filters = <Widget>[];

    for (var i = 0; i < activityFilters.length; i++) {
      final Map e = activityFilters[i];
      filters.add(ActivityFilterRow(
          icon: e['icon'],
          rowText: e['rowText'],
          onTap: () => e['custom'] as bool
              ? customFilterChosen(context)
              : filterChosen(i),
          iconPadding: iconPadding,
          rowPadding: rowPadding,
          color: e['color']));
    }

    return filters;
  }

  // Long variables

  /// Holds the various filter options, their back end filter types,
  /// Their current color, their icon, and whether they're the custom
  /// option or not.
  final activityFilters = [
    {
      'icon': Icons.bolt,
      'rowText': 'All Activity',
      'filterTypes': ['all'],
      'custom': false,
      'color': Colors.white
    },
    {
      'icon': Icons.alternate_email,
      'rowText': 'Mentions',
      'filterTypes': ['mention_in_reply', 'mention_in_post'],
      'custom': false,
      'color': Colors.white
    },
    {
      'icon': Icons.loop,
      'rowText': 'Reblogs',
      'filterTypes': ['reblog_naked', 'reblog_with_content'],
      'custom': false,
      'color': Colors.white
    },
    {
      'icon': Icons.chat_bubble,
      'rowText': 'Replies',
      'filterTypes': ['reply'],
      'custom': false,
      'color': Colors.white
    },
    {
      'icon': Icons.tune,
      'rowText': 'Custom',
      'filterTypes': [],
      'custom': true,
      'color': Colors.white
    }
  ];

  /// Holds the "tree" used in storing and drawing the custom options
  /// menu.
  final customFilters = {
    'Mentions': {
      'chosen': true,
      'Mentions in a post': true,
      'Mentions in a reply': true,
    },
    'Reblogs': {
      'chosen': true,
      'Reblogs with comment': true,
      'Reblogs without comment': true,
    },
    'New followers': true,
    'Likes': true,
    'Replies': true,
    'Asks': {'chosen': true, 'Received a new ask': true, 'Ask answered': true},
    'Note subscriptions': true,
    'Content Flagging': {
      'chosen': true,
      'Post flagged': true,
      'Appeal accepted': true,
      'Appeal rejected': true,
      'Spam reported': true
    },
    'Your GIF used in a post': true,
    'Posts you missed': true,
    'New group blog members': true
  };
}
