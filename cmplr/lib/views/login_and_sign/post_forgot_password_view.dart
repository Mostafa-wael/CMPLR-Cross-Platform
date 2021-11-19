import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class PostForgotPassword extends StatelessWidget {
  const PostForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        controller.returnFromSendResetEmail();
                      },
                    ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Okay, we just send you a password reset',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                'email',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Didn\'t get it? Check your spam folder if it\'s not',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                // TODO: Change "our help docs" to hyper link & bold
                // & white text
                'there, follow the tips in our help docs.',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
