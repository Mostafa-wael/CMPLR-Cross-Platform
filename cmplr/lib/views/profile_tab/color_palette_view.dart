import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

class ColorPaletteView extends StatelessWidget {
  const ColorPaletteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            // TODO, let this depend on theme
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              controller.goBack();
            },
          ),
          title: const Text(
            'Color Palette',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(),
          ],
        ),
      ),
    );
  }
}
