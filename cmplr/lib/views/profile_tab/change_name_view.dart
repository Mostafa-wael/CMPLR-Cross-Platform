import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

class ChangeNameView extends StatelessWidget {
  const ChangeNameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizing.blockSizeVertical * 5,
          toolbarTextStyle: Get.theme.appBarTheme.toolbarTextStyle,
          actionsIconTheme: Get.theme.iconTheme,
          leading: Padding(
            padding: EdgeInsets.only(left: Sizing.blockSize * 3),
            child: GestureDetector(
              child: const Text('cancel'),
              onTap: () {
                controller.goBack();
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Sizing.blockSize * 4),
              child: GestureDetector(
                child: const Text(
                  'Save',
                ),
                onTap: () {
                  controller.saveEdits(visibleKeyboard);
                },
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'What do you want to be called?',
                style: TextStyle(
                  fontSize: Sizing.fontSize * 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: Sizing.blockSize * 70,
                child: TextField(
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'name',
                  ),
                  controller: controller.changeNameController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
