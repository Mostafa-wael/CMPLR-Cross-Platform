import '../../controllers/login_and_sign/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class LoginEmail3 extends StatelessWidget {
  const LoginEmail3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<LoginManager>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 115),
              const Text(
                't',
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 115),
              (controller.emailController.text.isEmpty &&
                      controller.passwordController.text.isEmpty)
                  ? const Text(
                      'Log in',
                      style: TextStyle(color: Color(0x448AFFFF)),
                    )
                  : InkWell(
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        // TODO: go to home
                      },
                    ),
            ],
          ),
        ),
        body: visibleKeyboard
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Column(
                      children: [
                        LoginTextField(
                          controller: controller,
                          text: 'email',
                          focus: false,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: true,
                          iconColor: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        LoginTextField(
                          controller: controller,
                          text: 'password',
                          focus: true,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: false,
                          iconColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 240),
                  Center(
                    child: Column(
                      children: [
                        LoginTextField(
                          controller: controller,
                          text: 'email',
                          focus: false,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: true,
                          iconColor: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        LoginTextField(
                          controller: controller,
                          text: 'password',
                          focus: true,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: false,
                          iconColor: Colors.grey,
                        ),
                        const SizedBox(height: 200),
                        GestureDetector(
                          child: const Text(
                            'Forgot Your Password?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {},
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
