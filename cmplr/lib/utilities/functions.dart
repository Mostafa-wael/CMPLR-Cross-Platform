import 'sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../views/utilities/user_name_avatar.dart';

bool validateEmail(String email) {
  // return !email.isEmpty &&
  //     RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //         .hasMatch(email);

  return !email.isEmpty && email.isEmail;
}

String getErrors(List errors) {
  final buff = StringBuffer();
  for (final error in errors) {
    buff.writeln(error);
  }
  return buff.toString();
}

Future<void> showShareMenu(context, onTapOther) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    constraints: BoxConstraints(
      maxHeight: Sizing.blockSizeVertical * 90,
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizing.blockSize * 5)),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
            Sizing.blockSize * 4, 0, Sizing.blockSize * 4, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Sizing.blockSizeVertical * 3),
            Container(
              width: Sizing.blockSize * 12,
              height: Sizing.blockSize * 1,
              //TODO: Link this to theme
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizing.blockSize))),
            ),
            SizedBox(height: Sizing.blockSizeVertical * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserNameAvatar(),
              ],
            ),
            SizedBox(height: Sizing.blockSizeVertical * 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkResponse(
                  child: Column(
                    children: [
                      const Icon(Icons.copy),
                      const Text(
                        'Copy',
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                InkResponse(
                  child: Column(
                    children: [
                      const Icon(Icons.share),
                      const Text(
                        'Other',
                      )
                    ],
                  ),
                  onTap: onTapOther,
                ),
              ],
            ),
            SizedBox(
              height: Sizing.blockSizeVertical * 4,
            ),
            Container(
                width: Sizing.blockSize * 92,
                height: Sizing.blockSize * 0.25,
                color: Colors.white),
            SizedBox(
              height: Sizing.blockSizeVertical * 4,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizing.blockSize * 2),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: 'Type in your text',
                  fillColor: Colors.white70),
            ),
          ],
        ),
      );
    },
  );
}
