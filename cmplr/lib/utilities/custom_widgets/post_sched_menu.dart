import '../sizing/sizing.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

Widget postOption(String optionText, IconData icon, bool activated, onTap) {
  return Material(
    child: InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Sizing.blockSize * 2, 0, Sizing.blockSize * 3, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: Sizing.blockSize,
                ),
                Icon(icon),
                SizedBox(
                  width: Sizing.blockSize * 2,
                ),
                SizedBox(width: Sizing.blockSize * 2),
                Text(
                  optionText,
                  style: TextStyle(
                    fontSize: Sizing.fontSize * 4,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            activated
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        size: Sizing.blockSize * 7.25,
                        color: Colors.blue,
                      ),
                      Icon(
                        Icons.circle,
                        size: Sizing.blockSize * 5,
                        color: Colors.blue,
                      ),
                    ],
                  )
                : Icon(
                    Icons.circle_outlined,
                    size: Sizing.blockSize * 7.25,
                  ),
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}

Widget shareToTwitter(bool activated, controller) {
  return Material(
    child: InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Sizing.blockSize * 2, 0, Sizing.blockSize * 3, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: Sizing.blockSize,
                ),
                Text(
                  'Share to Twitter',
                  style: TextStyle(
                    fontSize: Sizing.fontSize * 4,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            activated
                ? Icon(
                    Icons.toggle_on_outlined,
                    size: Sizing.blockSize * 7.25,
                  )
                : Icon(
                    Icons.toggle_off_outlined,
                    size: Sizing.blockSize * 7.25,
                  ),
          ],
        ),
      ),
      onTap: () {
        //TODO: Implement the share to twitter logic in the controller
      },
    ),
  );
}
