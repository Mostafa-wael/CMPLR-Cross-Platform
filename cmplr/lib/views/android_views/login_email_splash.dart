import '../../controllers/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

class LoginEmailSplash extends StatelessWidget {
  const LoginEmailSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginManager>(
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

                  const SizedBox(height: 60),

                  const Text(

                    't',

                    style: TextStyle(

                        fontSize: 150,

                        color: Colors.white,

                        fontWeight: FontWeight.w900),

                  ),

                  const SizedBox(height: 290),

                  LoginTextField(

                    controller: controller,

                    text: 'email',

                    focus: false,
                    enabled: false,
                    underlineColor: Colors.grey,
                    isEmail: true,
                    iconColor: Colors.grey,
                  ),

                   const SizedBox(height: 10),
                   Opacity(
                     child: Container(
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      width: 340,
                      height: 40,
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
