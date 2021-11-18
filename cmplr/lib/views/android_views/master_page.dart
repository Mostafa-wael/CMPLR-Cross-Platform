import '../../controllers/master_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Please push

class MasterPage extends StatelessWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MasterPageController(),
        builder: (MasterPageController controller) {
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
