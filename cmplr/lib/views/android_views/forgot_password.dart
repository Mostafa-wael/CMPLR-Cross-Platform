import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: const Color(0xFF001A35),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
                  onPressed: () {
                    controller.closeForgotPassword();
                  },
                  splashRadius: 40,
                ),
                toolbarHeight: 80,
                actions: [
                  Stack(children: [
                    Center(
                      child: TextButton(
                          onPressed: () {
                            controller.submitButtonPressed();
                          },
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Color(controller.nextButtonColor),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800))),
                    ),
                    Positioned(
                      left: 22,
                      top: 22,
                      child: (controller.isLoading)
                          ? const CircularProgressIndicator(
                              color: Color(0xFF00CF36),
                              strokeWidth: 4.5,
                            )
                          : Container(color: Colors.transparent),
                    )
                  ]),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot your password? It happens. '
                        'We\'ll send you a link to reset it.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            height: 1.5),
                      ),
                      const SizedBox(height: 15),
                      LoginTextField(
                          textController: controller.emailController,
                          manager: controller,
                          text: 'email'),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: controller.showInvalidEmailError,
                        child: const Text(
                          'That doesn\'t look like an email address...'
                          'check it again?',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
