import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class UserNameAvatar extends StatelessWidget {
  final avatar;
  final name;
  final textStyle;
  const UserNameAvatar(this.avatar, this.name, this.textStyle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(avatar),
        ),
        SizedBox(width: Sizing.blockSize * 2),
        Text(name, style: textStyle),
      ],
    );
  }
}
