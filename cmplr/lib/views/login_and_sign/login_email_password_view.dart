import '../../utilities/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

class LoginEmailPassword extends StatelessWidget {
  const LoginEmailPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        backgroundColor: Get.theme.canvasColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          toolbarHeight: Sizing.blockSizeVertical * 10.5,
          elevation: 0.0,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, Sizing.blockSize, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Sizing.blockSize,
                ),
                Text(
                  'c',
                  style: TextStyle(
                      fontSize: Sizing.fontSize * 16.25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                controller.activateLoginButton
                    ? InkWell(
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.blueAccent),
                          key: ValueKey('getEmailPassword_login'),
                        ),
                        onTap: () {
                          controller.tryLogin();
                        },
                      )
                    : const Text(
                        'Log in',
                        style: TextStyle(color: Color(0x448AFFFF)),
                        key: ValueKey('getEmailPassword_login'),
                      )
              ],
            ),
          ),
        ),
        body: visibleKeyboard
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Sizing.blockSizeVertical * 16.5),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(Sizing.blockSizeVertical * 1.2),
                          child: Text(
                            controller.errors.isEmpty
                                ? ''
                                : getErrors(controller.errors),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        LoginTextField(
                          textFieldKey:
                              const ValueKey('getEmailPassword_getEmail'),
                          controller: controller,
                          text: 'email',
                          focus: false,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: true,
                          iconColor: Colors.grey,
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 0.5),
                        LoginTextField(
                          textFieldKey:
                              const ValueKey('getEmailPassword_getPassword'),
                          controller: controller,
                          text: 'password',
                          focus: false,
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
                  SizedBox(height: Sizing.blockSizeVertical * 25),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(Sizing.blockSizeVertical * 1.2),
                          child: Text(
                            controller.errors.isEmpty
                                ? ''
                                : getErrors(controller.errors),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        LoginTextField(
                          textFieldKey:
                              const ValueKey('getEmailPassword_getEmail'),
                          controller: controller,
                          text: 'email',
                          focus: false,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: true,
                          iconColor: Colors.grey,
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 1.5),
                        LoginTextField(
                          textFieldKey:
                              const ValueKey('getEmailPassword_getPassword'),
                          controller: controller,
                          text: 'password',
                          focus: true,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: false,
                          iconColor: Colors.grey,
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 30),
                      ],
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: GestureDetector(
                      child: Text(
                        'Forgot Your Password?',
                        style: TextStyle(
                          fontSize: Sizing.fontSize * 3.715,
                          color: Colors.grey,
                        ),
                        key: const ValueKey('getEmailPassword_forgotPassword'),
                      ),
                      onTap: () {
                        controller.forgotPassword();
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
