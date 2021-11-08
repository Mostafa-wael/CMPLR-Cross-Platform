import 'package:flutter/material.dart';

void main() {
  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Text(
          'CMPLR',
          style: TextStyle(fontSize: 25),
        )),
      ),
    );
  }
}
