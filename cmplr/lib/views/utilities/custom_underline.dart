import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Allows to define custom distance and width for underlined text.
/// From : https://github.com/flutter/flutter/issues/30541#issuecomment-552170487
class CustomUnderline extends StatelessWidget {
  final double underlineDistance, underlineWidth;
  final Text text;

  const CustomUnderline({
    this.underlineDistance = 1.0,
    this.underlineWidth = 1.0,
    this.text = const Text('Forgot this one!'),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: underlineDistance, // space between underline and text
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: text.style?.color ?? Colors.red, // Text colour here
        width: underlineWidth, // Underline width
      ))),
      child: text,
    );
  }
}
