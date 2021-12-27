import 'package:get_storage/get_storage.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

import '../user.dart';

class UserNameAvatar extends StatelessWidget {
  var textStyle;
  UserNameAvatar({Key? key, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyle ??= TextStyle(
      fontSize: Sizing.fontSize * 5,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipOval(
          child: CircleAvatar(child: User.avatarImage),
        ),
        SizedBox(width: Sizing.blockSize * 2),
        Text(GetStorage().read('blog_name'), style: textStyle),
      ],
    );
  }
}
