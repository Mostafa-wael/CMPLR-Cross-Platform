import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';

class SignupAge extends StatelessWidget {
  const SignupAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupAgeController>(
      init: SignupAgeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xFF001A35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
            onPressed: () {},
            splashRadius: 40,
          ),
          toolbarHeight: 80,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w800))),
              Positioned(
                left: 15,
                top: 7,
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
        body: Container(
          color: const Color(0xFF001A35),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
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
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            color: Colors.white, fontSize: 19, height: 1.4),
                        children: <TextSpan>[
                      TextSpan(
                          text: 'You\'re almost done.'
                              ' Enter your age, then tap the '),
                      TextSpan(
                          text: 'Next ',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      TextSpan(
                          text: 'button to indicate that you\'ve read the '),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600)),
                      TextSpan(text: ' and agree to the '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
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
