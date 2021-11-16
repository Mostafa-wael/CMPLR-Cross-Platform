
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../controllers/controllers.dart';


class LoginEmail extends StatelessWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  static Widget _getBody(context) => Stack(
    children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            const Text(
              't',
              style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(height: 235),
          ],
        ),
      ),
      Center(
        child: SignUpInPageView(
          texts: ['Explore', 'mind-blowing stuff'],
        ),
      ),
    ],
  );
}