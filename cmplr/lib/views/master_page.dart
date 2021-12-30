import '../utilities/custom_widgets/draggable_floating_action_button.dart';

import '../views/views.dart';

import '../controllers/master_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/sizing/sizing.dart';

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
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            body: IndexedStack(
                index: controller.currPage, children: controller.pages),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Get.theme.textSelectionTheme.selectionColor,
              currentIndex: controller.currPage,
              onTap: (index) {
                controller.changePage(index);
              },
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home, key: ValueKey('masterPage_home')),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search, key: ValueKey('masterPage_search')),
                  label: 'Search',
                ),
                const BottomNavigationBarItem(
                  icon:
                      Icon(Icons.message, key: ValueKey('masterPage_activity')),
                  label: 'Activity',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person, key: ValueKey('masterPage_profile')),
                  label: 'Profile',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              key: const ValueKey('masterPage_write_post'),
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

class MasterFloatingActionButton extends StatelessWidget {
  const MasterFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.favorite),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.camera_alt_rounded),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(Icons.code),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.flutter_dash_rounded),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        child: const Icon(Icons.android_rounded),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.favorite),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.camera_alt_rounded),
      ),
    ];

    return DraggableFloatingActionButton(
      key: const ValueKey('masterPage_write_post'),
      delayBias: 150, // bias in milliseconds
      // the widgets that will be animated
      children: buttons,
      // required paramerters
      initialOffset: Offset(MediaQuery.of(context).size.width * 0.85,
          MediaQuery.of(context).size.height * 0.9),
      onPressed: () {
        Get.to(
          const WritePost(),
          transition: Transition.downToUp,
        );
      },
    );
  }
}
