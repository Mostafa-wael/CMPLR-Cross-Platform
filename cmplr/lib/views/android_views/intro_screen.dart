import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  static Widget _getBody(context) => Stack(
        children: [
          Center(
            child: SignUpInPageView(texts: [
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
                const SizedBox(height: 120),
                const Text(
                  'tumblr',
                  style: TextStyle(
                      fontSize: 56,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 320),
                InkWell(
                  child: SignUpInButton(
                    text: 'Sign Up',
                    onTap: (context) {
                      //Get.to();
                    },
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  onTap: () {},
                ),
                const SizedBox(height: 15),
                SignUpInButton(
                  text: 'Log in',
                  onTap: () {
                    //Get.to();
                  },
                )
              ],
            ),
          ),
        ],
      );
}
