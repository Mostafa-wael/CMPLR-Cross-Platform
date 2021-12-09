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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
                      fontSize: Sizing.blockSize * 16.25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(width: Sizing.blockSize * 24.5),
                controller.activateLoginButton
                    ? InkWell(
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onTap: () {
                          controller.tryLogin();
                        },
                      )
                    : const Text(
                        'Log in',
                        // TODO: AAAAAAAAAAAAAA
                        style: TextStyle(color: Color(0x448AFFFF)),
                      )
              ],
            ),
          ),
        ),
        body: visibleKeyboard
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Sizing.blockSizeVertical * 22.5),
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
                        SizedBox(height: Sizing.blockSizeVertical * 1.5),
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
                  SizedBox(height: Sizing.blockSizeVertical * 34),
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
                        SizedBox(height: Sizing.blockSizeVertical * 1.5),
                        LoginTextField(
                          controller: controller,
                          text: 'password',
                          focus: true,
                          enabled: true,
                          underlineColor: Colors.grey,
                          isEmail: false,
                          iconColor: Colors.grey,
                        ),
                        SizedBox(height: Sizing.blockSizeVertical * 30),
                        GestureDetector(
                          child: Text(
                            'Forgot Your Password?',
                            style: TextStyle(
                              fontSize: Sizing.blockSize * 3.715,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            controller.forgotPassword();
                          },
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
