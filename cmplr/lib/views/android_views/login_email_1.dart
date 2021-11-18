import '../../controllers/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

class LoginEmail1 extends StatelessWidget {
  const LoginEmail1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return GetBuilder<LoginManager>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
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
                  visibleKeyboard
                      ? const SizedBox(height: 20)
                      : const SizedBox(height: 60),
                  visibleKeyboard
                      ? const Text(
                          't',
                          style: TextStyle(
                              fontSize: 75,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        )
                      : const Text(
                          't',
                          style: TextStyle(
                              fontSize: 150,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                  visibleKeyboard
                      ? const SizedBox(height: 60)
                      : const SizedBox(height: 290),
                  LoginTextField(
                    controller: controller,
                    text: 'email',
                    focus: true,
                    enabled: true,
                    underlineColor: Colors.blueAccent,
                    isEmail: true,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Material(
                      child: InkWell(
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        onTap: () {
                          controller.validateEmail();
                        },
                        splashFactory: NoSplash.splashFactory,
                      ),
                      color: Colors.blueAccent,
                    ),
                    width: 340,
                    height: 40,
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
