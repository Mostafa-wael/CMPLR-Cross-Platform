import '../../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/utility_views.dart';
import '../../utilities/sizing/sizing.dart';

class LoginEmailOrGoogle extends StatelessWidget {
  const LoginEmailOrGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                    key: const ValueKey('login_withEmail'),
                    text: 'Log in with Email',
                    onTap: () {
                      controller.loginEmail();
                    },
                  ),
                  SizedBox(height: Sizing.blockSizeVertical * 2.25),
                  SignUpInButton(
                    key: const ValueKey('login_withGmail'),
                    text: 'Log in with Google',
                    onTap: () {
                      controller.loginGoogle(context);
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
