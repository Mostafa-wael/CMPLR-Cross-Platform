import '../../models/pages_model/home_tab/reblog_model.dart';
import '../../utilities/custom_widgets/write_post_or_reblog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/external/external.dart';
import '../../utilities/sizing/sizing.dart';

// TODO: DRAFTS
class ReblogView extends StatelessWidget {
  const ReblogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return GetBuilder<ReblogController>(
      init: ReblogController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizing.blockSizeVertical * 12,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  top: Sizing.blockSizeVertical * 1.8,
                  bottom: Sizing.blockSizeVertical * 1.8),
              child: TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Sizing.blockSize * 2, right: Sizing.blockSize * 2),
                  child: Text(
                    'Reblog',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizing.blockSize * 4.2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightBlue[400] ?? Colors.blue),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
              ),
            ),
            IconButton(
                onPressed: () {
                  // https://api.flutter.dev/flutter/material/showModalBottomSheet.html
                },
                icon: const Icon(Icons.more_vert))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Sizing.blockSizeVertical * 6),
            child: Padding(
              padding: EdgeInsets.all(Sizing.blockSize * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // (Tarek) TODO: Get the user's image and name
                  // Can be cached on login
                  const CircleAvatar(
                      backgroundImage: AssetImage(
                          'lib/utilities/assets/logo/logo_icon.png')),
                  SizedBox(width: Sizing.blockSize * 2),
                  Text('Username',
                      style: TextStyle(
                          fontSize: Sizing.blockSize * 4.2,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsets.all(Sizing.blockSize * 3),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Sizing.blockSizeVertical * 90,
                            child: Container(
                              child: const Center(child: Text('Post')),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                      color: Colors.grey.shade900,
                                      width: Sizing.blockSize * 0.5)),
                            ),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 1.2),
                          TextField(
                            focusNode: controller.textFocus,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add something, if you\'d like'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            // TODO: Swap this out to the text editing bottom bar when text
            // is highlighted
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Sizing.blockSize * 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Add tags to help people find your post',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizing.blockSize * 3.715),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey[900] ?? Colors.red),
                          shape:
                              MaterialStateProperty.all(const StadiumBorder())),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Sizing.blockSize * 3),
                  child: Row(
                    children: [
                      FocusedMenuHolder(
                          menuOffset: Sizing.blockSize * 2.5,
                          menuItemExtent: Sizing.blockSize * 10,
                          duration: const Duration(milliseconds: 200),
                          menuWidth: Sizing.blockSize * 30,
                          blurSize: 0,
                          maxMenuHeightPercentage: 0.9,
                          animateMenuItems: false,
                          onPressed: () {
                            controller.focusOnText();
                          },
                          blurBackgroundColor:
                              const Color.fromRGBO(0, 10, 26, 0),
                          openWithTap: false,
                          menuItems: controller.textModes.keys
                              .map((e) => FocusedMenuItem(
                                  title: Text(
                                    e.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    controller.setMode(e);
                                  }))
                              .toList(),
                          child: const Icon(Icons.text_fields)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.link)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.gif)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.image)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.headphones)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.tag),
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
=======
    return WritePostOrReblog(const ReblogModel(), Get.find<ReblogController>());
>>>>>>> Stashed changes
  }
}
