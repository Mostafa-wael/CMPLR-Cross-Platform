import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  static Widget _getBody(context) => Stack(
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
            const SizedBox(height: 100),
            /*const Text(
              'Explore',
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'mind-blowing stuff.',
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),
            ),*/
            const SizedBox(height: 120),
            InkWell(
              child: SignUpInButton(
                text: 'Log in with Email',
                onTap: (context) {
                 //Get.to();
                },
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              onTap: () {

              },
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

