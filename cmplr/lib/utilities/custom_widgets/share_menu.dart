import 'package:fluttertoast/fluttertoast.dart';

import '../../user.dart';
import 'user_name_avatar.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

Future<dynamic> shareMenu(user, controller, context, profilePhoto, name) {
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
                UserNameAvatar(
                    // TODO: Replace with user name & user avatar
                    // profilePhoto,
                    // User1.userData['email'],
                    // TextStyle(
                    //   fontSize: Sizing.fontSize * 4,
                    //   fontWeight: FontWeight.bold,
                    // )
                    ),
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
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: 'Test1'));
                    controller.back();
                    _showToast('Copied to clipboard');
                  },
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
                  onTap: () {
                    controller.back();
                    controller.share(context, 'Test1');
                  },
                ),
              ],
            ),
            SizedBox(
              height: Sizing.blockSizeVertical * 4,
            ),
            Container(
                width: Sizing.blockSize * 92,
                height: Sizing.blockSize * 0.25,
                color: Colors.grey),
            SizedBox(
              height: Sizing.blockSizeVertical * 2.5,
            ),
            SizedBox(
              height: Sizing.blockSizeVertical * 5,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Send to...',
                  hintStyle: TextStyle(
                    fontSize: Sizing.fontSize * 3.5,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: Sizing.blockSize * 3),
                    borderRadius: BorderRadius.circular(Sizing.blockSize * 3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Sizing.blockSize * 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Tumblrs',
                  style: TextStyle(
                    fontSize: Sizing.fontSize * 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
