import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

/// Intor screen taht allows the user to choose between sign up or login
class SignupOrLoginScreen extends StatelessWidget {
  const SignupOrLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizing.width = MediaQuery.of(context).size.width;
    Sizing.height = MediaQuery.of(context).size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    return GetBuilder<SignupLoginController>(
      init: SignupLoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: Get.theme.canvasColor,
        body: Stack(
          children: [
            Center(
              child: TextWithImagesPageView(texts: [
                'Explore mind-blowing stuff.',
                'Follow Tumblrs that spark your interests.',
                'Customize how you look, be who you want.',
                'post anything: Text, GIFs, music, whatever.',
                'Welcome to Tumblr. Now push the button.',
              ], imagePathes: [
                'lib/utilities/assets/intro_screen/intro_1.gif',
                'lib/utilities/assets/intro_screen/intro_2.gif',
                'lib/utilities/assets/intro_screen/intro_3.jpg',
                'lib/utilities/assets/intro_screen/intro_4.jpg',
                'lib/utilities/assets/intro_screen/intro_5.gif',
              ]),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Sizing.blockSizeVertical * 18),
                  Text(
                    'Cmplr',
                    style: TextStyle(
                        fontSize: Sizing.fontSize * 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: Sizing.blockSizeVertical * 48),
                  SignUpInButton(
                    key: const ValueKey('introScreen_signUp'),
                    text: 'Sign Up',
                    onTap: () {
                      controller.signUp();
                    },
                  ),
                  SizedBox(height: Sizing.blockSizeVertical * 2.25),
                  SignUpInButton(
                    key: const ValueKey('introScreen_logIn'),
                    text: 'Log in',
                    onTap: () {
                      controller.signIn();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
