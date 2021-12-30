import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: const ValueKey('Settings_back'),
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
            'Account',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: FadeInImage.assetNetwork(
            placeholder: 'lib/utilities/assets/logo/cmplr_logo_icon.png',
            image: controller.headerImage,
            fit: BoxFit.cover,
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  key: const ValueKey('Settings_AccountSettings'),
                  title: 'Account Settings',
                  subtitle: 'Notifications, subscriptions, replies, all that',
                  onPressed: (BuildContext context) {
                    controller.goToAccountSettings();
                  },
                ),
              ],
            ),
            SettingsSection(
              titleTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              title: controller.blogName,
              tiles: [],
            ),
            SettingsSection(
              tiles: [
                SettingsTile(
                  key: const ValueKey('Settings_ChangeName'),
                  title: 'Change Name',
                  onPressed: (BuildContext context) {
                    controller.goToChangeName(visibleKeyboard);
                  },
                ),
                SettingsTile(
                  title: 'Pages',
                  subtitle: 'Visible pages on your cmplr',
                  onPressed: (BuildContext context) {},
                ),
                // TODO: these need num followers & num of posts,
                // If back returns them
                SettingsTile(
                  title: 'Followers',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Drafts',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Queue',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Inbox',
                  subtitle: 'Asks, submissions',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Review flagged posts',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Visibility',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Linked accounts',
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Allow submissions',
                  switchValue: controller.allowSubmissions,
                  onToggle: (bool value) {
                    controller.toggleSubmissions();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Let people use mdia in ask',
                  switchValue: controller.useMedia,
                  onToggle: (bool value) {
                    controller.toggleUseMedia();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Let people ask questions',
                  switchValue: controller.ask,
                  onToggle: (bool value) {
                    controller.toggleAsk();
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Show top posts',
                  switchValue: controller.topPosts,
                  onToggle: (bool value) {
                    controller.toggleShowTopPosts();
                  },
                ),
                SettingsTile(
                  title: 'Blocked Tumblrs',
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
