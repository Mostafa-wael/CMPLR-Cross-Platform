import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            toolbarHeight: Sizing.blockSizeVertical * 10.5,
            elevation: 0.0,
            title: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, Sizing.blockSize, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Sizing.blockSize * 28.5),
                  Text(
                    't',
                    style: TextStyle(
                        fontSize: Sizing.fontSize * 16.25,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: Sizing.blockSize * 22.5),
                  controller.activateSubmitButton
                      ? InkWell(
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.blueAccent),
                            key: ValueKey('forgotPassword_submit'),
                          ),
                          onTap: () {
                            controller.sendResetEmail();
                          },
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(color: Color(0x448AFFFF)),
                          key: ValueKey('forgotPassword_submit'),
                        ),
                ],
              ),
            ),
          ),
          body: visibleKeyboard
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: Sizing.blockSizeVertical * 18),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Forgot your password? It happens.',
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 5.6,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 1.5),
                          Text(
                            'We\'ll send you a link to reset it.',
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 5.6,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 3),
                          LoginTextField(
                            controller: controller,
                            text: 'email',
                            focus: false,
                            enabled: true,
                            underlineColor: Colors.grey,
                            isEmail: true,
                            iconColor: Colors.grey,
                            textFieldKey:
                                const ValueKey('forgotPassword_getEmail'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: Sizing.blockSizeVertical * 30),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Forgot your password? It happens.',
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 5.6,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 1.5),
                          Text(
                            'We\'ll send you a link to reset it.',
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 5.6,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 3),
                          LoginTextField(
                            controller: controller,
                            text: 'email',
                            focus: false,
                            enabled: true,
                            underlineColor: Colors.grey,
                            isEmail: true,
                            iconColor: Colors.grey,
                            textFieldKey:
                                const ValueKey('forgotPassword_getEmail'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
