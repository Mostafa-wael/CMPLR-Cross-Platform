import '../../utilities/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/external/external.dart';
import '../../utilities/sizing/sizing.dart';

// TODO: DRAFTS
class WritePost extends StatelessWidget {
  const WritePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<WritePostController>(
      init: WritePostController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizing.blockSizeVertical * 12,
          leading: IconButton(
            icon: Icon(Icons.close, size: Sizing.blockSize * 6.2),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  top: Sizing.blockSizeVertical * 1.8,
                  bottom: Sizing.blockSizeVertical * 1.8),
              child: ActionChip(
                label: Text(
                  'Post',
                  style: TextStyle(
                    fontSize: Sizing.fontSize * 4.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {},
                backgroundColor: Colors.black26,
              ),
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                        // TODO: Make this variable according to schedule
                        maxHeight: Sizing.blockSizeVertical * 60),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Sizing.blockSize * 5)),
                    builder: (BuildContext context) {
                      return GetBuilder<WritePostController>(
                          builder: (controller) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  Container(
                                    width: Sizing.blockSize * 12,
                                    height: Sizing.blockSize * 1,
                                    //TODO: Link this to theme
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Sizing.blockSize))),
                                  ),
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Sizing.blockSize * 38,
                                      ),
                                      Text(
                                        'Post options',
                                        style: TextStyle(
                                          fontSize: Sizing.fontSize * 4.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Sizing.blockSize * 24,
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 4,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Sizing.blockSizeVertical * 3,
                                  ),
                                  postOption(
                                      'Post Now',
                                      Icons.edit,
                                      controller.isActivated(
                                          postOptions.postNow), () {
                                    controller
                                        .setPostOption(postOptions.postNow);
                                  }),
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  scheduleOption(
                                      controller
                                          .isActivated(postOptions.schedule),
                                      controller,
                                      context),
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  postOption(
                                      'Save as draft',
                                      Icons.drafts_outlined,
                                      controller.isActivated(
                                          postOptions.saveAsDraft), () {
                                    controller
                                        .setPostOption(postOptions.saveAsDraft);
                                  }),
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  postOption(
                                      'Post privately',
                                      Icons.lock_outline,
                                      controller.isActivated(
                                          postOptions.postPrivately), () {
                                    controller.setPostOption(
                                        postOptions.postPrivately);
                                  }),
                                  SizedBox(
                                      height: Sizing.blockSizeVertical * 3),
                                  controller.isActivated(
                                              postOptions.saveAsDraft) ||
                                          controller.isActivated(
                                              postOptions.postPrivately)
                                      ? Container()
                                      : shareToTwitter(
                                          controller.isActivated(
                                              postOptions.shareToTwitter),
                                          controller),
                                ],
                              ));
                    },
                  );
                },
                icon: Icon(Icons.more_vert, size: Sizing.blockSize * 7.5)),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Sizing.blockSizeVertical * 6),
            child: Padding(
              padding: EdgeInsets.all(Sizing.blockSize * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // (Tarek) TODO: Get the user's image and name
                  // Can be cached on login
                  CircleAvatar(
                      backgroundImage: AssetImage(controller.userAvatar)),
                  SizedBox(width: Sizing.blockSize * 2),
                  Text(controller.userName,
                      style: TextStyle(
                          fontSize: Sizing.fontSize * 4.2,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsets.all(Sizing.blockSize * 3),
                      child: Column(
                        children: [
                          SizedBox(height: Sizing.blockSize * 1.2),
                          TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add something, if you\'d like'),
                            maxLines: null,
                            style: TextStyle(
                              decoration: controller.strikethough
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: controller.bold
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontStyle:
                                  controller.italic ? FontStyle.italic : null,
                              color: controller.currentColor,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            // TODO: Swap this out to the text editing bottom bar when text
            // is highlighted
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                visibleKeyboard
                    ? Padding(
                        padding: EdgeInsets.only(left: Sizing.blockSize * 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Add tags to help people find your post',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizing.fontSize * 3.715),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey[900] ?? Colors.red),
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder())),
                            onPressed: () {},
                          ),
                        ),
                      )
                    : SizedBox(
                        height: Sizing.blockSizeVertical * 0.1,
                      ),
                SizedBox(height: Sizing.blockSizeVertical * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < controller.allColors.length; i++)
                      InkWell(
                        child: TwoNestedCircles(
                            Colors.white, controller.allColors[i], 7.25, 5),
                        onTap: () {
                          controller.changeColor(i);
                        },
                      ),
                  ],
                ),
                SizedBox(height: Sizing.blockSizeVertical),
                Padding(
                  padding: EdgeInsets.only(
                      left: Sizing.blockSize * 3, right: Sizing.blockSize * 3),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.link)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.image)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.toggleBold();
                          },
                          icon: const Icon(Icons.format_bold)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.toggleItalic();
                          },
                          icon: const Icon(Icons.format_italic)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.toggleStrikethrough();
                          },
                          icon: const Icon(Icons.strikethrough_s)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.tag),
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

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
