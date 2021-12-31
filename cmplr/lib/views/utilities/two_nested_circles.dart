import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TwoNestedCircles extends StatelessWidget {
  final outerSize, innerSize, outerColor, innerColor;

  const TwoNestedCircles(
      this.outerColor, this.innerColor, this.outerSize, this.innerSize,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.circle_outlined,
          size: Sizing.blockSize * outerSize,
          color: outerColor,
        ),
        Icon(
          Icons.circle,
          size: Sizing.blockSize * innerSize,
          color: innerColor,
        ),
      ],
    );
  }
}
