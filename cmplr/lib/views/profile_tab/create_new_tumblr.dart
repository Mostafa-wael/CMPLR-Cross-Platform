import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../utilities/sizing/sizing.dart';

import '../../controllers/profile/create_new_tumblr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewTumblr extends StatelessWidget {
  const CreateNewTumblr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: remove this once the create tumblr view is done
    if (Sizing.blockSizeVertical == null) {
      Sizing.width = MediaQuery.of(context).size.width;
      Sizing.height = MediaQuery.of(context).size.height;
      Sizing.blockSize = Sizing.width / 100;
      Sizing.blockSizeVertical = Sizing.height / 100;
      Sizing.setFontSize();
    }
    return GetBuilder(
      init: CreateNewTumblrController(),
      builder: (CreateNewTumblrController controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
              color: Colors.white,
            ),
            title: const Text(
              'Create a new Tumblr',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  child: Text('Save',
                      style: TextStyle(color: Colors.lightBlue[700])),
                  onPressed: () {
                    // FIXME: send request to backend
                  })
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizing.blockSize * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Sizing.blockSizeVertical * 5,
                  child: Row(children: [
                    Image(
                        height: Sizing.blockSizeVertical * 5,
                        width: Sizing.blockSizeVertical * 5,
                        image: const AssetImage(
                            'lib/utilities/assets/logo/logo_icon.png')),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizing.blockSize * 4),
                        child: TextField(
                          decoration: const InputDecoration(hintText: 'name'),
                          controller: controller.nameFieldController,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      onPressed: controller.clearNameField,
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
