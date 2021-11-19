import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<LoginController>(
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
              const SizedBox(width: 100),
              (controller.emailController.text.isEmpty &&
                      controller.passwordController.text.isEmpty)
                  ? const Text(
                      'Submit',
                      style: TextStyle(color: Color(0x448AFFFF)),
                    )
                  : InkWell(
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        controller.sendResetEmail();
                      },
                    ),
            ],
          ),
        ),
        body: visibleKeyboard
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Forgot your password? It happens.',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'We\'ll send you a link to reset it.',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        LoginTextField(
                          controller: controller,
                          text: 'email',
                          focus: false,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: true,
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
            const SizedBox(height: 200),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Forgot your password? It happens.',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We\'ll send you a link to reset it.',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  LoginTextField(
                    controller: controller,
                    text: 'email',
                    focus: false,
                    enabled: true,
                    underlineColor: Colors.grey,
                    isEmail: true,
                    iconColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
