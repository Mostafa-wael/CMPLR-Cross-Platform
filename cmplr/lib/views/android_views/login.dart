import 'dart:ui';

import 'package:cmplr/controllers/login_manager.dart';
import 'package:cmplr/views/android_views/android_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginManager>(
      init: LoginManager(),
      builder: (controller) => Scaffold(
        body: _getBody(context, controller),
      ),
    );
  }

  static Widget _getBody(context, controller) => Stack(
    children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            const Text(
              'tumblr',
              style: TextStyle(
                fontSize: 56,
                color: Colors.white,
                fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(height: 220),
            SignUpInButton(
              text: 'Log in with Email',
              onTap: () {
                controller.UseEmail();
                print('here');
              }
            ),
            const SizedBox(height: 15),
            SignUpInButton(
              text: 'log in with Google',
              onTap: () {
                //Get.to();
              },
            )
          ],
        ),
      ),
      Center(
        child: SignUpInPageView(
          texts: ['Explore', 'mind-blowing stuff'],
        ),
      ),
    ],
  );

}

