import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';

class SignupAge extends StatelessWidget {
  const SignupAge({Key? key}) : super(key: key);

  static const _privacyPolicyURL = 'https://www.tumblr.com/privacy';

  static const _termsOfServiceURL = 'https://www.tumblr.com'
      '/policy/en/terms-of-service';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupAgeController>(
      init: SignupAgeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
              onPressed: () {
                controller.closeAgeScreen();
              },
              splashRadius: Sizing.blockSize * 10),
          toolbarHeight: Sizing.blockSizeVertical * 12,
          actions: [
            Stack(children: [
              TextButton(
                  onPressed: () {
                    controller.nextButtonPressed();
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Text('Next',
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
          color: Theme.of(context).scaffoldBackgroundColor,
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
                  controller: controller.ageController,
                  focusNode: controller.focusNode,
                  maxLength: 3,
                  autofocus: true,
                  cursorColor: Colors.grey,
                  style: const TextStyle(color: Colors.white),
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
                SizedBox(height: Sizing.blockSizeVertical * 2.25),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizing.fontSize * 4.45,
                            height: Sizing.blockSizeVertical * 0.2),
                        children: <TextSpan>[
                      const TextSpan(
                          text: 'You\'re almost done.'
                              ' Enter your age, then tap the '),
                      const TextSpan(
                          text: 'Next ',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      const TextSpan(
                          text: 'button to indicate that you\'ve read the '),
                      TextSpan(
                          text: 'Privacy Policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.launchURL(_privacyPolicyURL);
                            },
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600)),
                      const TextSpan(text: ' and agree to the '),
                      TextSpan(
                        text: 'Terms of Service',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.launchURL(_termsOfServiceURL);
                          },
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600),
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
