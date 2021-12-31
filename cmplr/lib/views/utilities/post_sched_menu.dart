import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';

class PostOptions {
  // postNow
  static const postNow = 'publish';

  static const schedule = 'schedule';

  // saveAsDraft
  static const String saveAsDraft = 'draft';
  // postPrivately
  static const String postPrivately = 'private';
  // shareToTwitter // Not in the backend

  static const String shareToTwitter =
      'THIS SHOULDN\'T BE HERE, IT\'S NOT THE BACKEND\'S RESPONSIBILITY';
}

Widget postOption(String optionText, IconData icon, bool activated, onTap,
    {String? subtext}) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      optionText,
                      style: TextStyle(
                        fontSize: Sizing.fontSize * 4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (subtext != null) Text(subtext),
                  ],
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: Sizing.blockSize * 7.25,
                  color: Colors.blue,
                ),
                if (activated)
                  Icon(
                    Icons.circle,
                    size: Sizing.blockSize * 5,
                    color: Colors.blue,
                  ),
              ],
            )
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
            Icon(
              activated ? Icons.toggle_on_outlined : Icons.toggle_off_outlined,
              size: Sizing.blockSize * 7.25,
            )
          ],
        ),
      ),
      onTap: () {
        //TODO: Implement the share to twitter logic in the controller
      },
    ),
  );
}

Widget scheduleOption(bool activated, WritePostController controller, context) {
  return Material(
      child: Column(
    children: [
      postOption('Schedule', Icons.access_time, activated, () {
        controller.setPostOption(PostOptions.schedule);
      }, subtext: controller.date),
      SizedBox(height: Sizing.blockSizeVertical * 1.5),
      if (activated)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                controller.setDateTime(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.date.split('at')[0],
                    style: TextStyle(
                      fontSize: Sizing.fontSize * 3.75,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: Sizing.blockSize,
                  ),
                  const Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
            SizedBox(width: Sizing.blockSize * 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                controller.setTimeOfDay(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.date.split('at')[1],
                    style: TextStyle(
                      fontSize: Sizing.fontSize * 3.75,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: Sizing.blockSize,
                  ),
                  const Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ],
        ),
    ],
  ));
}
