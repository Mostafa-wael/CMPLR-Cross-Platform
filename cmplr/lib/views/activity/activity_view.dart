import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
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
        // TODO: refresh the selected page
      },
      child: const Text('Refresh'),
    ),
    value: 'Refresh',
  ),
  DropdownMenuItem(
    child: TextButton(
      onPressed: () {
        // TODO: Go to settings
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
              child: DropdownButton<String>(
                items: moreItems,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onChanged: (value) {},
              ),
            )
          ],
          bottom: getTabBar(context),
        ),

        /// The home screen, it has 2 tabs: Following and stuff for you

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
