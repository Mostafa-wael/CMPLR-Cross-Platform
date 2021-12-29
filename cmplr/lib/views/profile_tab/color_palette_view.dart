import 'package:get/get.dart';
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
            SettingsSection(
              tiles: [
                SettingsTile.switchTile(
                  title: 'True Blue',
                  subtitle: 'Tried and true default cmplr blue.',
                  switchValue: controller.trueBlue,
                  onToggle: (bool value) {
                    controller.setTrueBlue();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  subtitle: 'Turn down the lights.',
                  switchValue: controller.darkMode,
                  onToggle: (bool value) {
                    controller.setDarkMode();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
