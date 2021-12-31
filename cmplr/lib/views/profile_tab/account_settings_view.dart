import '../../utilities/user.dart';
import '../login_and_sign/signup_or_login_view.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: const ValueKey('AccountSettings_back'),
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              controller.goBack();
            },
          ),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: 'Logins Options',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Post+ Subscriptions',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Notifications',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Messaging',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Replies',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Sounds',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Privacy',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Dashboard Preferences',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Flitering',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  key: const ValueKey('AccountSettings_ColorPalette'),
                  title: 'Color palette',
                  onPressed: (BuildContext context) {
                    controller.goToColorPalette();
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Uploading & Downloading',
              titleTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              tiles: [
                SettingsTile(
                  title: 'Media auto-play',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Optimize videos',
                  subtitle:
                      'Enable to resize and compress video before uploading',
                  switchValue: controller.optimizeVideo,
                  onToggle: (bool value) {
                    controller.toggleOptimizeVids();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Show upload progress',
                  subtitle: 'This lets you know when your post has uploaded'
                      ' successfully',
                  switchValue: controller.showUploadProg,
                  onToggle: (bool value) {
                    controller.toggleShowUploadProg();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Disable double tap to like',
                  switchValue: controller.disableDoubleTapToLike,
                  onToggle: (bool value) {
                    controller.toggleDisableDoubleTapToLike();
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Account',
              titleTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              tiles: [
                SettingsTile(
                  title: 'Labs',
                  leading: const Icon(Icons.science),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Help',
                  leading: const Icon(Icons.help),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Report Abuse',
                  leading: const Icon(Icons.report),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  key: const ValueKey('AccountSettings_Logout'),
                  title: 'Logout',
                  leading: const Icon(Icons.logout),
                  onPressed: (BuildContext context) {
                    User.logOut();
                    Get.offAll(const SignupOrLoginScreen());
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
