import 'package:flutter/material.dart';

/// A popup that can house other widgets inside.
///
/// You can define it's min/max width/height, along with a background color
/// Always centered.
class Popup extends StatelessWidget {
  final double maxHeight, minHeight, maxWidth, minWidth;
  final Widget child;
  final Color backgroundColor;

  const Popup(this.child,
      {Key? key,
      this.maxWidth = 390,
      this.maxHeight = 150,
      this.minWidth = 260,
      this.minHeight = 100,
      this.backgroundColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            minWidth: minWidth,
            minHeight: minHeight),
        child: ElevatedButton(
          onPressed: () {},
          child: child,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              splashFactory: NoSplash.splashFactory),
        ),
      ),
    );
  }
}
