import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:getwidget/getwidget.dart';
import '../../models/models.dart';
import '../../controllers/controllers.dart';
import '../../utilities/custom_icons/custom_icons.dart';
import '../../utilities/sizing/sizing.dart';

// This preserves the scroll state of the list view,
// It is used due to this issue in Getx: https://github.com/jonataslaw/getx/issues/822
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  const RefreshWidget({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);
  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: widget.child, onRefresh: widget.onRefresh);
  }
}

class Notes extends StatelessWidget {
  Notes({Key? key}) : super(key: key);

  var controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
        init: NotesController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: const Color(0xFF001A35),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFEFE)),
                onPressed: () {
                  controller.closeNotesScreen();
                },
                splashRadius: Sizing.blockSize * 7.5,
              ),
              title: Text(
                '${Get.arguments} notes',
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                Obx(() => IconButton(
                      icon: Icon(controller.postSubscribed.value
                          ? Icons.notifications
                          : Icons.notifications_off_outlined),
                      color: Colors.white,
                      iconSize: Sizing.blockSize * 7.415,
                      onPressed: () {
                        controller.subscriptionButtonPressed();
                      },
                    )),
              ],
            ),
            body: getBody(context)));
  }

  Widget getBody(BuildContext context) {
    if (!NotesController.dataReloaded) {
      return FutureBuilder(
          future: controller.notesModel.getNotes(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              controller.notes = snapshot.data ?? [];
              return buildMainView(context);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          });
    } else {
      return buildMainView(context);
    }
  }

  Widget buildMainView(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Material(
            child: InkWell(
                onTap: () {},
                child: TabBar(
                  controller: controller.tabController,
                  indicatorColor: Colors.lightBlue,
                  tabs: <Widget>[
                    Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CustomIcons.comment,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text(
                            '${controller.notes![0].length}',
                            style: const TextStyle(),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CustomIcons.reblog,
                            // color: Colors.black,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text(
                              '${controller.notes![1].length + controller.notes![2].length}',
                              style: const TextStyle(
                                  // color: Colors.black
                                  ))
                        ],
                      ),
                    ),
                    Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.heart,
                            size: Sizing.blockSize * 5.44,
                            // color: Colors.black,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text('${controller.notes![3].length}',
                              style: const TextStyle(
                                  // color: Colors.black
                                  ))
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                    child: KeepAliveWrapper(
                        child: RefreshWidget(
                      onRefresh: () {
                        return controller.refreshScreen();
                      },
                      child: RefreshWidget(
                        onRefresh: () {
                          return controller.refreshScreen();
                        },
                        child: ListView.builder(
                          itemCount: controller.notes![0].length,
                          itemBuilder: (context, index) {
                            return buildCommentsListTile(
                                controller.notes![0][index],
                                index == controller.notes![0].length - 1);
                          },
                        ),
                      ),
                    )),
                  ),
                  Container(
                    height: Sizing.blockSizeVertical * 6.44,
                    width: Sizing.width,
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 0.5)),
                    ),
                    child: Obx(() => Row(
                          children: [
                            controller.focusCommentTextField.value
                                ? const Text('@')
                                : const Text('image'),
                            SizedBox(width: Sizing.blockSize * 4.87),
                            SizedBox(
                              width: Sizing.blockSize * 68.12,
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  controller
                                      .commentTextFieldFocusChanged(hasFocus);
                                },
                                child: TextField(
                                  onChanged: (value) {
                                    controller.commentTextFieldChanged(value);
                                  },
                                  maxLines: 2,
                                  decoration: const InputDecoration(
                                      hintText: 'Unleash a compliment ',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                    width: Sizing.blockSize * 14.59,
                                    child: const Center(child: Text('Reply'))),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      getModalSheet(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.fromLTRB(Sizing.blockSize * 4.5, 0, 0, 0),
                      height: 50,
                      width: Sizing.width,
                      child: Row(
                        children: [
                          Obx(() => Text(
                                controller.reblogsWithComments.value
                                    ? 'Reblogs with comments'
                                    : 'Other reblogs',
                                style:
                                    TextStyle(fontSize: Sizing.blockSize * 4.2),
                              )),
                          Icon(Icons.arrow_drop_down,
                              size: Sizing.blockSize * 7.415)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: KeepAliveWrapper(
                    child: Obx(() => controller.reblogsWithComments.value
                        ? RefreshWidget(
                            onRefresh: () {
                              return controller.refreshScreen();
                            },
                            child: ListView.builder(
                                itemCount: controller.notes![1].length,
                                itemBuilder: (context, index) {
                                  return // AAAAAAAAAAA
                                      buildReblogsWithCommentsListTile(
                                          controller.notes![1][index]);
                                }),
                          )
                        : RefreshWidget(
                            onRefresh: () {
                              return controller.refreshScreen();
                            },
                            child: ListView.builder(
                                itemCount: controller.notes![2].length,
                                itemBuilder: (context, index) {
                                  return buildOtherReblogsListTile(
                                      controller.notes![2][index]);
                                }),
                          )),
                  ))
                ],
              ),
              KeepAliveWrapper(
                  child: RefreshWidget(
                onRefresh: () {
                  return controller.refreshScreen();
                },
                child: ListView.builder(
                    itemCount: controller.notes![3].length,
                    itemBuilder: (context, index) {
                      return buildLikesListTile(
                          controller.notes![3][index], index);
                    }),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommentsListTile(UserNote note, bool lastComment) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          Sizing.blockSize * 4.5,
          Sizing.blockSizeVertical * 3.0,
          0,
          Sizing.blockSizeVertical * 3.0 * (lastComment ? 1 : 0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              print('User profile tapped');
            },
            child: note.avatarShape == 'circle'
                ? CircleAvatar(
                    backgroundImage: NetworkImage(note.avatarURL),
                    radius: Sizing.blockSize * 4.45,
                  )
                : GFAvatar(
                    backgroundImage: NetworkImage(note.avatarURL),
                    shape: GFAvatarShape.square,
                    backgroundColor: Colors.white,
                    size: Sizing.blockSize * 5.9,
                  ),
          ),
          SizedBox(width: Sizing.blockSize * 3.71),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onLongPress: () {
              print('Comment long press');
            },
            child: Container(
              width: Sizing.blockSize * 78,
              padding: EdgeInsets.fromLTRB(
                  Sizing.blockSize * 2.5,
                  Sizing.blockSizeVertical * 1.5,
                  Sizing.blockSize * 2.5,
                  Sizing.blockSizeVertical * 1.5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizing.blockSize * 4))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.blogName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: Sizing.blockSize * 4.2,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    note.postReply,
                    style: TextStyle(
                      fontSize: Sizing.blockSize * 4.2,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildReblogsWithCommentsListTile(UserNote note) {
    return InkWell(
      onLongPress: () {
        print('Hold reblog with comment tile');
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: 50,
                  child: Stack(
                    children: [
                      note.avatarShape == 'circle'
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(note.avatarURL),
                              radius: Sizing.blockSize * 3.7,
                            )
                          : GFAvatar(
                              backgroundImage: NetworkImage(note.avatarURL),
                              shape: GFAvatarShape.square,
                              backgroundColor: Colors.white,
                              size: Sizing.blockSize * 5.1,
                            ),
                      Positioned(
                        child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: Sizing.blockSize * 1.85,
                            child: Center(
                                child: Icon(CustomIcons.reblog,
                                    size: Sizing.blockSize * 2.0,
                                    color: Colors.white))),
                        bottom: 0,
                        right: 14,
                      )
                    ],
                  )),
              InkWell(
                onTap: () {
                  print('User profile tapped');
                },
                child: SizedBox(
                  width: 120,
                  child: Text(
                    note.blogName,
                    style: TextStyle(
                      fontSize: Sizing.blockSize * 4.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            width: Sizing.width,
            child: Text(
              note.postReply,
              style: TextStyle(
                fontSize: Sizing.blockSize * 4.2,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
          Row(
            children: [
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print('Reblog button pressed');
                    },
                    child: Container(
                        height: Sizing.blockSizeVertical * 6.75,
                        padding: EdgeInsets.fromLTRB(Sizing.blockSize * 2.5, 0,
                            Sizing.blockSize * 2.5, 0),
                        child: Center(
                            child: Text(
                          'Reblog',
                          style: TextStyle(
                              fontSize: Sizing.blockSize * 4.65,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ))),
                  )),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print('View post button pressed');
                    },
                    child: Container(
                        height: Sizing.blockSizeVertical * 6.75,
                        padding: EdgeInsets.fromLTRB(Sizing.blockSize * 2.5, 0,
                            Sizing.blockSize * 2.5, 0),
                        child: Center(
                            child: Text(
                          'View post',
                          style: TextStyle(
                              fontSize: Sizing.blockSize * 4.65,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ))),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget buildOtherReblogsListTile(UserNote note) {
    return InkWell(
      onTap: () {
        print('User profile tapped');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Sizing.blockSize * 12.16,
              child: Stack(
                children: [
                  note.avatarShape == 'circle'
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(note.avatarURL),
                          radius: Sizing.blockSize * 3.7,
                        )
                      : GFAvatar(
                          backgroundImage: NetworkImage(note.avatarURL),
                          shape: GFAvatarShape.square,
                          backgroundColor: Colors.white,
                          size: Sizing.blockSize * 5.1,
                        ),
                  Positioned(
                    child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: Sizing.blockSize * 1.85,
                        child: Center(
                            child: Icon(CustomIcons.reblog,
                                size: Sizing.blockSize * 3.5,
                                color: Colors.white))),
                    bottom: 0,
                    right: 14,
                  )
                ],
              ),
            ),
            Text(
              note.blogName + '  ',
              style: TextStyle(
                fontSize: Sizing.blockSize * 4.2,
              ),
            ),
            InkWell(
              onTap: () {
                print('User profile tapped');
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CustomIcons.reblog),
                  Text(
                    '  ' + note.blogName,
                    style: TextStyle(
                      fontSize: Sizing.blockSize * 4.2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLikesListTile(UserNote note, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('User profile tapped');
        },
        child: Container(
          height: Sizing.blockSizeVertical * 9.75,
          padding: EdgeInsets.fromLTRB(
              Sizing.blockSize * 3.71,
              Sizing.blockSizeVertical * 1.5,
              Sizing.blockSize * 1.24,
              Sizing.blockSizeVertical * 1.5),
          child: Stack(children: [
            Row(
              children: [
                note.avatarShape == 'circle'
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(note.avatarURL),
                        radius: Sizing.blockSize * 4.45,
                      )
                    : GFAvatar(
                        backgroundImage: NetworkImage(note.avatarURL),
                        shape: GFAvatarShape.square,
                        backgroundColor: Colors.white,
                        size: Sizing.blockSize * 5.9,
                      ),
                SizedBox(width: Sizing.blockSize * 3.71),
                SizedBox(
                  width: Sizing.blockSize * 55.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.blogName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        note.profileTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizing.blockSize * 4.2,
                          fontWeight: FontWeight.w400,
                          // color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Sizing.blockSize * 5.9),
              ],
            ),
            Positioned(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // TODO: send a post request to follow the user
                      print('Follow button pressed');
                      controller.notes?[3][index].followed.value =
                          !controller.notes![3][index].followed.value;
                    },
                    child: Container(
                        height: Sizing.blockSizeVertical * 6.75,
                        padding: EdgeInsets.fromLTRB(Sizing.blockSize * 2.5, 0,
                            Sizing.blockSize * 2.5, 0),
                        child: Obx(() => Center(
                            child: controller.notes![3][index].followed.value
                                ? Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: Sizing.blockSize * 4.65,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.lightBlue),
                                  )
                                : Text(
                                    'Follow',
                                    style: TextStyle(
                                        fontSize: Sizing.blockSize * 4.65,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.lightBlue),
                                  )))),
                  )),
              right: 0,
            )
          ]),
        ),
      ),
    );
  }

  Future<void> getModalSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: Sizing.blockSizeVertical * 30),
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<NotesController>(
              builder: (controller) => Obx(
                    () => Column(
                      children: [
                        const Icon(Icons.line_weight),
                        SizedBox(height: Sizing.blockSizeVertical * 4.5),
                        InkWell(
                          onTap: () {
                            if (!controller.reblogsWithComments.value) {
                              controller.reblogsWithComments.value = true;
                            }
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                            height: Sizing.blockSizeVertical * 8.78,
                            width: Sizing.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Sizing.blockSize * 80.29,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reblogs with comments',
                                        style: TextStyle(
                                            fontSize: Sizing.blockSize * 4.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Show reblogs with added comments and/or tags.',
                                        style: TextStyle(
                                            fontSize: Sizing.blockSize * 4.2),
                                        overflow: TextOverflow.visible,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Sizing.blockSize * 4.86,
                                ),
                                Visibility(
                                  visible: controller.reblogsWithComments.value,
                                  child: Icon(CustomIcons.check,
                                      size: Sizing.blockSize * 5),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Sizing.blockSizeVertical),
                        InkWell(
                          onTap: () {
                            if (controller.reblogsWithComments.value) {
                              controller.reblogsWithComments.value = false;
                            }
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                            height: Sizing.blockSizeVertical * 8.78,
                            width: Sizing.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Sizing.blockSize * 80.29,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Other reblogs',
                                        style: TextStyle(
                                            fontSize: Sizing.blockSize * 4.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Show empty reblogs.',
                                        style: TextStyle(
                                            fontSize: Sizing.blockSize * 4.2),
                                        overflow: TextOverflow.visible,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Sizing.blockSize * 4.86,
                                ),
                                Visibility(
                                  visible:
                                      !controller.reblogsWithComments.value,
                                  child: Icon(CustomIcons.check,
                                      size: Sizing.blockSize * 5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
        });
  }
}
