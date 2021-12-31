import '../../controllers/controllers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/utility_views.dart';
import '../../utilities/sizing/sizing.dart';

class LoginEmailSplash extends StatelessWidget {
  const LoginEmailSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Sizing.blockSizeVertical * 9),
                          Text(
                            'c',
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 43.5),
                          LoginTextField(
                            controller: controller,
                            text: 'email',
                            focus: false,
                            enabled: false,
                            underlineColor: Colors.grey,
                            isEmail: true,
                            iconColor: Colors.grey,
                            textFieldKey: const ValueKey('Spash_getEmail'),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 1.5),
                          Opacity(
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontSize: Sizing.fontSize * 3.715,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              width: Sizing.blockSize * 84,
                              height: Sizing.blockSizeVertical * 6,
                              color: Colors.blueAccent,
                            ),
                            opacity: 0.4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
