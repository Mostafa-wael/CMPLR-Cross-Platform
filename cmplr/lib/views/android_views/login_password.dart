import '../../controllers/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

class LoginPassword extends StatelessWidget {
  const LoginPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginManager>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
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
        body: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginTextField(
                    textController: controller.emailController,
                    manager: controller,
                    text: 'email'),
                LoginTextField(
                    textController: controller.passwordController,
                    manager: controller,
                    text: 'password'),
              ],
            ),
          ),
          Positioned(
            child: TextButton(
              onPressed: () {
                controller.forgotPassword();
              },
              child: const Text('Forgot your password?'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
            bottom: 5,
            left: 125,
          )
        ]),
      ),
    );
  }
}
