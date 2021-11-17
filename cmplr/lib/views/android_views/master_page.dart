import 'package:cmplr/controllers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({Key? key}) : super(key: key);

  static List<Widget> _getPages() {
    return [
      const Center(child: Text('Home')),
      const Center(child: Text('Search')),
      const Center(child: Text('Activity')),
      const Center(child: Text('Profile')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppStateManager(pages: _getPages()),
        builder: (AppStateManager controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'CMPLR',
                  style: Theme.of(context).textTheme.headline6,
                ),
                actions: [],
              ),
              body: IndexedStack(
                  index: controller.currPage, children: controller.pages),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                currentIndex: controller.currPage,
                onTap: (index) {
                  controller.changePage(index);
                },
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Activity',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ));
        });
  }
}
