import '../views/views.dart';

import '../../controllers/master_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/sizing/sizing.dart';

// Please push

class MasterPage extends StatelessWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizing.width = MediaQuery.of(context).size.width;
    Sizing.height = MediaQuery.of(context).size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    return GetBuilder(
        init: MasterPageController(),
        builder: (MasterPageController controller) {
          return Scaffold(
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
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.edit),
              onPressed: () {
                Get.to(
                  const WritePost(),
                  transition: Transition.downToUp,
                );
              },
              backgroundColor: Colors.blue,
            ),
          );
        });
  }
}
