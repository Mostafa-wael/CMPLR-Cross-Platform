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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
                  't',
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
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: Sizing.blockSizeVertical * 15),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.all(Sizing.blockSizeVertical * 0.5),
                        //   child: Text(
                        //     controller.errors.isEmpty
                        //         ? ''
                        //         : getErrors(controller.errors),
                        //     style: const TextStyle(color: Colors.red),
                        //   ),
                        // ),
                        LoginTextField(
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
                  SizedBox(height: Sizing.blockSizeVertical * 20),
                  // Padding(
                  //   padding: EdgeInsets.all(Sizing.blockSizeVertical * 1.2),
                  //   child: Text(
                  //     controller.errors.isEmpty
                  //         ? ''
                  //         : getErrors(controller.errors),
                  //     style: const TextStyle(color: Colors.red),
                  //   ),
                  // ),
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
                        // SizedBox(height: Sizing.blockSizeVertical * 30),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: GestureDetector(
                      child: Text(
                        'Forgot Your Password?',
                        style: TextStyle(
                          fontSize: Sizing.fontSize * 3.715,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        controller.forgotPassword();
                      },
                    ),
                  )),
                  SizedBox(
                    height: Sizing.blockSizeVertical,
                  )
                ],
              ),
      ),
    );
  }
}
