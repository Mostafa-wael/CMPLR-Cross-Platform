import 'dart:ui';

import '../../utilities/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

// TODO: Fix it with the CMPLRTheme.trueBlue()
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

  static final _maxWidth = Sizing.blockSize * 98.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
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
  static AppBar _getAppBar(context) => AppBar(
        actions: [
          GetBuilder<EmailPasswordNameAfterSignupController>(
              builder: (controller) {
            return TextButton(
              key: const ValueKey('completeSignUp_done'),
              onPressed: () {
                controller.validateInfo();
              },
              child: controller.getDoneButton(context),
            );
          })
        ],
        elevation: 0,
      );

  /// Top column containing 2 Text, 3 TextField for email, password, name.
  static Widget _getTopColumn(
          context, EmailPasswordNameAfterSignupController controller) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Sizing.blockSizeVertical * 2.4),
          Text(
            _subtitle,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(Sizing.blockSizeVertical * 1.2),
            child: Text(
              controller.validInfo ? '' : getErrors(controller.errors),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextField(
            key: const ValueKey('completeSignUp_email'),
            controller: controller.emailController,
            decoration: const InputDecoration(hintText: 'email'),
            onChanged: controller.fieldChanged,
          ),
          SizedBox(height: Sizing.blockSizeVertical * 1.2),
          TextField(
            key: const ValueKey('completeSignUp_password'),
            controller: controller.passwordController,
            decoration: InputDecoration(
                hintText: 'password',
                suffixIcon: IconButton(
                  key: const ValueKey('completeSignUp_eye'),
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
            onChanged: controller.fieldChanged,
          ),
          SizedBox(height: Sizing.blockSizeVertical * 1.2),
          TextField(
            key: const ValueKey('completeSignUp_name'),
            controller: controller.nameController,
            decoration: const InputDecoration(hintText: 'name'),
            onChanged: controller.fieldChanged,
          ),
        ],
      );

  /// Login popup to confirm with the user.
  static Widget _getLoginPopup(
          context, EmailPasswordNameAfterSignupController controller) =>
      Popup(
        Padding(
          padding: EdgeInsets.only(
            left: Sizing.blockSize,
            right: Sizing.blockSize,
            top: Sizing.blockSizeVertical * 2.4,
            bottom: Sizing.blockSizeVertical * 2.4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _nevermindText,
                style: TextStyle(fontSize: Sizing.fontSize * 3.715),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  child: Text(
                    'Nevermind',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(width: Sizing.blockSize * 4),
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
        maxHeight: Sizing.blockSizeVertical * 18,
      );

  /// Bottom column containing 1 Text, 2 Pressable texts (to login/ privacy policy)
  static Widget _getBottomColumn(
          context, EmailPasswordNameAfterSignupController controller) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(fontSize: Sizing.fontSize * 4.65),
          ),
          GestureDetector(
              key: const ValueKey('completeSignUp_login'),
              child: CustomUnderline(
                text: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: Sizing.fontSize * 4.65,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                underlineDistance: Sizing.blockSizeVertical * 0.15,
                underlineWidth: Sizing.blockSize * 0.25,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return _getLoginPopup(context, controller);
                    });
              }),
          GestureDetector(
            key: const ValueKey('completeSignUp_privacy'),
            child: CustomUnderline(
              text: Text(
                'Privacy dashboard',
                style: TextStyle(
                    fontSize: Sizing.fontSize * 4.65,
                    color: Theme.of(context).secondaryHeaderColor),
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
            padding: EdgeInsets.symmetric(
                horizontal: Sizing.blockSize * 15.85,
                vertical: Sizing.blockSizeVertical * 2.4),
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
          );
        },
      ));
}
