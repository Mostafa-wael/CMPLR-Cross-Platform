import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

class LoginSignupAgeGoogle extends StatelessWidget {
  const LoginSignupAgeGoogle({Key? key}) : super(key: key);

  static const _privacyPolicyURL = 'https://www.tumblr.com/privacy';

  static const _termsOfServiceURL = 'https://www.tumblr.com'
      '/policy/en/terms-of-service';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xFF001A35),
          leading: IconButton(
              key: const ValueKey('signUpAge_back'),
              icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
              onPressed: () {
                controller.closeAgeScreen();
              },
              splashRadius: Sizing.blockSize * 10),
          toolbarHeight: Sizing.blockSizeVertical * 12,
          actions: [
            Stack(children: [
              TextButton(
                  key: const ValueKey('signUpAge_next'),
                  onPressed: () {
                    controller.signupGoogle(context);
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Text('Signup',
                      style: TextStyle(
                          color: Color(controller.nextButtonColor),
                          fontSize: Sizing.fontSize * 4.65,
                          fontWeight: FontWeight.w800))),
              Positioned(
                left: Sizing.blockSize * 3.5,
                top: Sizing.blockSizeVertical,
                child: (controller.isLoading)
                    ? CircularProgressIndicator(
                        color: const Color(0xFF00CF36),
                        strokeWidth: Sizing.blockSize * 1.2,
                      )
                    : Container(color: Colors.transparent),
              )
            ]),
          ],
        ),
        body: Container(
          color: const Color(0xFF001A35),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Sizing.blockSize * 6,
              Sizing.blockSizeVertical * 0.75,
              Sizing.blockSize * 6,
              Sizing.blockSizeVertical * 0.75,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizing.blockSizeVertical * 7.5,
                ),
                TextFormField(
                  key: const ValueKey('signUpAge_getAge'),
                  controller: controller.ageController,
                  focusNode: controller.focusNode,
                  maxLength: 3,
                  autofocus: true,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                      color: Colors.white, fontSize: Sizing.fontSize * 4.0),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (text) {
                    controller.ageFieldChanged();
                  },
                  decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: Visibility(
                        visible: controller.showClearButton,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {
                            controller.ageController.clear();
                            controller.ageFieldChanged();
                          },
                        ),
                      ),
                      hintText: 'How old are you?',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontSize: Sizing.fontSize * 4.65),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(height: Sizing.blockSizeVertical * 5),
                TextField(
                  controller: controller.signupGoogleController,
                  decoration: const InputDecoration(
                    hintText: 'Create a Username',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
