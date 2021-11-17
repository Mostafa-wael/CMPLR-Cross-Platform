import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';

class LoginEmailSplash extends StatelessWidget {
  const LoginEmailSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
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
                const SizedBox(height: 235),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
