import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

/// The screen that shows when you choose to sign up with email
/// then go to your profile.
class EmailPasswordNameAfterSignup extends StatelessWidget {
  const EmailPasswordNameAfterSignup({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(),
        body: _getBody(context),
        resizeToAvoidBottomInset: false);
  }

  static AppBar _getAppBar() => AppBar(
        actions: [
          GetBuilder<EmailPasswordNameAfterSignupController>(
              builder: (controller) {
            return TextButton(
              onPressed: () {
                // (Tarek) TODO: Wire this up correctly
                // Replace this page by the new profile if the data is valid
                controller.validateInfo();
                controller.toProfile();
              },
              child: const Text('Done'),
            );
          })
        ],
        elevation: 0,
      );

  static Widget _getTopColumn(context, controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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

  static Widget _getBottomColumn(
          context, EmailPasswordNameAfterSignupController controller) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  static Widget _getBody(context) => Center(
          child: GetBuilder<EmailPasswordNameAfterSignupController>(
        init: EmailPasswordNameAfterSignupController(),
        builder: (controller) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getTopColumn(context, controller),
                    _getBottomColumn(context, controller)
                  ],
                ),
              ));
        },
      ));
}
