import 'package:cmplr/controllers/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

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
        body: Center(
          child: Column(
            children: [
              LoginTextField(textController: controller.emailController,
                  manager: controller, text: 'email'),
              LoginTextField(textController: controller.passwordController
                  , manager: controller, text: 'password'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
