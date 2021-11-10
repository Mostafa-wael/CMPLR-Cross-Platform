import 'package:flutter/material.dart';
import 'views/android_views/signup_age.dart';

void main() {
  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SignupAge();
  }
}
