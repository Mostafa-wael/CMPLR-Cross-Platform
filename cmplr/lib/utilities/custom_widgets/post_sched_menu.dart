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

Widget scheduleOption(bool activated, controller, context) {
  return Material(
    child: activated
        ? Column(
            children: [
              InkWell(
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
                            const Icon(Icons.schedule),
                            SizedBox(
                              width: Sizing.blockSize * 2,
                            ),
                            SizedBox(width: Sizing.blockSize * 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Schedule',
                                  style: TextStyle(
                                    fontSize: Sizing.fontSize * 4,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  controller.date,
                                  style: TextStyle(
                                      fontSize: Sizing.fontSize * 3,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
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
                            Icon(
                              Icons.circle,
                              size: Sizing.blockSize * 5,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    controller.setPostOption(postOptions.schedule);
                  }),
              SizedBox(height: Sizing.blockSizeVertical * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.transparent),
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
                    style:
                        ElevatedButton.styleFrom(primary: Colors.transparent),
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
          )
        : InkWell(
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
                      const Icon(Icons.schedule),
                      SizedBox(
                        width: Sizing.blockSize * 2,
                      ),
                      SizedBox(width: Sizing.blockSize * 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schedule',
                            style: TextStyle(
                              fontSize: Sizing.fontSize * 4,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            controller.date,
                            style: TextStyle(
                                fontSize: Sizing.fontSize * 3,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.circle_outlined,
                    size: Sizing.blockSize * 7.25,
                  ),
                ],
              ),
            ),
            onTap: () {
              controller.setPostOption(postOptions.schedule);
            }),
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
