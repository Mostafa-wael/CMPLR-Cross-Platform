import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

/// The screen that shows when you choose to sign up with email
/// then go to your profile.
class SignupMailName extends StatelessWidget {
  const SignupMailName({Key? key}) : super(key: key);

  static const _title = 'What should we call you?';
  static const _subtitle = 'You\'ll need a name to make your own posts,'
      ' customize your blog, and message people.';

  static const _privacyDashboardURL =
      'https://www.tumblr.com/privacy/redirect?redirect'
      '_url=https%3A%2F%2Fwww.tumblr.com%2Fsettings%2Fp'
      'rivacy&token=Rn0vCK3pbPXcTWYkWlo.O1L8sWUraCpKsxD'
      'XhLN1QXKbamPu4mu6lbOAwEvoSQF7vUkPakvSUaVyS997YXz'
      'f2DpD_joMp_LACTB9puk9RQ.5';

  static const _nevermindText = 'Hold on! Are you sure you have '
      ' another'
      ' account? It would stink to lose'
      ' everything you just followed.';

  static const _maxWidth = 400.0;
  static double screenWidth = 1920, screenHeight = 1080;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    screenWidth = mq.size.width;
    screenHeight = mq.size.height;

    return Scaffold(
        appBar: _getAppBar(),
        body: GetBuilder<MasterPageController>(
          builder: (MasterPageController controller) {
            return _getBody(context, controller);
          },
        ),
        resizeToAvoidBottomInset: true);
  }

  /// Only one button that should route to the page the user was intending on.
  ///
  /// If the user isn't logged in, an extra signup page shows up.
  /// When the user fills their data properly and presses 'done', this should
  /// route them to the page they intended on originally. (activity/profile)/
  static AppBar _getAppBar() => AppBar(
        actions: [
          GetBuilder<EmailPasswordNameAfterSignupController>(
              builder: (controller) {
            return TextButton(
              onPressed: () {
                controller.validateInfo();
              },
              child: const Text('Done'),
            );
          })
        ],
        elevation: 0,
      );

  /// Top column containing 2 Text, 3 TextField for email, password, name.
  static Widget _getTopColumn(context, controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            _subtitle,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              controller.validInfo ? '' : 'Invalid information',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(hintText: 'email')),
          const SizedBox(height: 8),
          TextField(
            controller: controller.passwordController,
            decoration: InputDecoration(
                hintText: 'password',
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.passwordHidden
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                  onPressed: () {
                    controller.togglePasswordHide();
                  },
                )),
            obscureText: controller.passwordHidden,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const SizedBox(height: 8),
          TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(hintText: 'name')),
        ],
      );

  /// Login popup to confirm with the user.
  static Widget _getLoginPopup(
          EmailPasswordNameAfterSignupController controller) =>
      Popup(
        Padding(
          padding:
              const EdgeInsets.only(left: 4, right: 4, top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                _nevermindText,
                style: TextStyle(fontSize: 16),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  child: const Text(
                    'Nevermind',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 16),
                GestureDetector(
                    child: Text(
                      'I\'m sure',
                      style: TextStyle(color: Colors.blue[400]),
                    ),
                    onTap: () {
                      controller.toLogin();
                    })
              ])
            ],
          ),
        ),
        backgroundColor: Colors.grey[900] ?? Colors.grey,
        maxHeight: 120,
      );

  /// Bottom column containing 1 Text, 2 Pressable texts (to login/ privacy policy)
  static Widget _getBottomColumn(
          context, EmailPasswordNameAfterSignupController controller) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(fontSize: 20),
          ),
          GestureDetector(
              child: CustomUnderline(
                text: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.blue[600]),
                ),
                underlineDistance: 1,
                underlineWidth: 1,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return _getLoginPopup(controller);
                    });
              }),
          GestureDetector(
            child: CustomUnderline(
              text: Text(
                'Privacy dashboard',
                style: TextStyle(fontSize: 20, color: Colors.blue[600]),
              ),
            ),
            onTap: () {
              controller.launchURL(_privacyDashboardURL);
            },
          ),
        ],
      );

  /// The body contains the top and bottom columns, centered.
  static Widget _getBody(context, masterPageController) => Center(
          child: GetBuilder<EmailPasswordNameAfterSignupController>(
        init: EmailPasswordNameAfterSignupController(),
        builder: (controller) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              child: SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ListView(children: [
                      _getTopColumn(context, controller),
                    ])),
                    const SizedBox(
                      height: 32,
                    ),
                    _getBottomColumn(context, controller)
                  ],
                ),
              ));
        },
      ));
}
