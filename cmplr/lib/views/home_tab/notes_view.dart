import '../../utilities/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../utilities/custom_widgets/custom_widgets.dart';

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
                '${controller.postItem?.numNotes} notes',
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
    if (!controller.dataReloaded) {
      return FutureBuilder(
          future: controller.notesModel.getNotes(controller.postItem!.postID),
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
                          Icon(
                            CustomIcons.comment,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text(
                            '${controller.notes![0].length}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.reblog,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text(
                              (controller.notes![1].length +
                                      controller.notes![2].length)
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
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
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: Sizing.blockSize * 3.71),
                          Text('${controller.notes![3].length}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
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
                      child: ListView.builder(
                        controller: controller.commentListViewController,
                        itemCount: controller.notes![0].length,
                        itemBuilder: (context, index) {
                          return buildCommentsListTile(
                              controller.notes![0][index],
                              index == controller.notes![0].length - 1,
                              context);
                        },
                      ),
                    )),
                  ),
                  Container(
                    height: Sizing.blockSizeVertical * 6.5,
                    width: Sizing.width,
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 0.5)),
                    ),
                    child: Obx(() => Row(
                          children: [
                            SizedBox(
                              width: Sizing.blockSize * 1.94,
                            ),
                            controller.focusCommentTextField.value
                                ? InkWell(
                                    onTap: () {
                                      controller.addStringToComment('@');
                                    },
                                    child: SizedBox(
                                        width: Sizing.blockSize * 6.81,
                                        child: Text(
                                          '@',
                                          style: TextStyle(
                                              fontSize: Sizing.blockSize * 5.59,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          textAlign: TextAlign.center,
                                        )),
                                  )
                                : InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      controller.addStringToComment('@');
                                    },
                                    child: GetStorage().read('avatar_shape') ==
                                            'circle'
                                        ? CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(User.avatarURL),
                                            radius: Sizing.blockSize * 3.4,
                                          )
                                        : GFAvatar(
                                            shape: GFAvatarShape.square,
                                            backgroundImage:
                                                NetworkImage(User.avatarURL),
                                            size: Sizing.blockSize * 4.6,
                                          ),
                                  ),
                            SizedBox(width: Sizing.blockSize * 4.87),
                            SizedBox(
                              width: Sizing.blockSize * 68.12,
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  controller
                                      .commentTextFieldFocusChanged(hasFocus);
                                },
                                child: TextField(
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  focusNode:
                                      controller.commentTextFieldFocusNode,
                                  onChanged: (value) {
                                    controller.commentTextFieldChanged(value);
                                  },
                                  controller:
                                      controller.commentTextFieldController,
                                  maxLines: 2,
                                  decoration: const InputDecoration(
                                    hintText: 'Unleash a compliment...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Sizing.blockSize * 2.91,
                            ),
                            Material(
                                color: Colors.transparent,
                                child: Obx(
                                  () => controller.emptyCommentTextField.value
                                      ? InkWell(
                                          child: SizedBox(
                                              width: Sizing.blockSize * 14.59,
                                              child: Center(
                                                  child: Text(
                                                'Reply',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Sizing.blockSize *
                                                        3.64),
                                              ))),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            controller.commentSubmitted();
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: SizedBox(
                                              width: Sizing.blockSize * 14.59,
                                              child: Center(
                                                  child: Text(
                                                'Reply',
                                                style: TextStyle(
                                                    color: Colors.lightBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Sizing.blockSize *
                                                        3.64),
                                              ))),
                                        ),
                                ))
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      getReblogsModalSheet(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.fromLTRB(Sizing.blockSize * 4.5, 0, 0, 0),
                      height: Sizing.blockSizeVertical * 7.32,
                      width: Sizing.width,
                      child: Row(
                        children: [
                          Obx(() => Text(
                                controller.reblogsWithComments.value
                                    ? 'Reblogs with comments'
                                    : 'Other reblogs',
                                style: TextStyle(
                                    fontSize: Sizing.blockSize * 4.2,
                                    color: Theme.of(context).primaryColor),
                              )),
                          Icon(Icons.arrow_drop_down,
                              size: Sizing.blockSize * 7.415,
                              color: Theme.of(context).primaryColor)
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
                                          controller.notes![1][index], context);
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
                                      controller.notes![2][index], context);
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
                          controller.notes![3][index], index, context);
                    }),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommentsListTile(
      UserNote note, bool lastComment, BuildContext context) {
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
              FocusScope.of(context).unfocus();
              getCommentModalSheet(context, note.blogName, note.postReply);
            },
            child: Container(
              width: Sizing.blockSize * 78,
              padding: EdgeInsets.fromLTRB(
                  Sizing.blockSize * 2.5,
                  Sizing.blockSizeVertical * 1.5,
                  Sizing.blockSize * 2.5,
                  Sizing.blockSizeVertical * 1.5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(Sizing.blockSize * 4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.blogName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: Sizing.blockSize * 4.2,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    note.postReply,
                    style: TextStyle(
                        fontSize: Sizing.blockSize * 4.2,
                        color: Theme.of(context).primaryColor),
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

  Widget buildReblogsWithCommentsListTile(UserNote note, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              Sizing.blockSize * 3.1, 0, 0, Sizing.blockSize * 3.1),
          child: Row(
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
                  )),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  print('User profile tapped');
                },
                child: SizedBox(
                  width: Sizing.blockSize * 70.55,
                  child: Text(
                    note.blogName,
                    style: TextStyle(
                        fontSize: Sizing.blockSize * 4.2,
                        color: Theme.of(context).primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_horiz,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  getReblogsWithCommentsModalSheet(
                      context, note.blogName, note.postReply);
                },
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              Sizing.blockSize * 3.1, 0, 0, Sizing.blockSize * 3.1),
          width: Sizing.width,
          child: Text(
            note.postReply,
            style: TextStyle(
                fontSize: Sizing.blockSize * 4.2,
                color: Theme.of(context).primaryColor),
            overflow: TextOverflow.visible,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: Sizing.blockSize * 1.09,
            ),
            Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.reblogFromNotes();
                  },
                  child: Container(
                      height: Sizing.blockSizeVertical * 6.75,
                      padding: EdgeInsets.fromLTRB(
                          Sizing.blockSize * 2.5, 0, Sizing.blockSize * 2.5, 0),
                      child: Center(
                          child: Text(
                        'Reblog',
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.65,
                            fontWeight: FontWeight.w500,
                            color: Colors.lightBlue),
                      ))),
                )),
            // TODO: Might change this to 'go to user profile'
            Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('View post button pressed');
                  },
                  child: Container(
                      height: Sizing.blockSizeVertical * 6.75,
                      padding: EdgeInsets.fromLTRB(
                          Sizing.blockSize * 2.5, 0, Sizing.blockSize * 2.5, 0),
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
    );
  }

  Widget buildOtherReblogsListTile(UserNote note, BuildContext context) {
    return InkWell(
      onTap: () {
        print('User profile tapped');
      },
      child: Container(
        padding: EdgeInsets.all(Sizing.blockSize * 2.91),
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
                  color: Theme.of(context).primaryColor),
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
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLikesListTile(UserNote note, int index, BuildContext context) {
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
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        note.profileTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.2,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor),
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

  Widget buildModalSheetTile(String text, var onTapFunction) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: EdgeInsets.fromLTRB(Sizing.blockSize * 2.91, 0, 0, 0),
        height: Sizing.blockSizeVertical * 7,
        width: Sizing.width,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(fontSize: Sizing.blockSize * 3.89),
            )),
      ),
    );
  }

  Future<void> getCommentModalSheet(
      BuildContext context, String blogName, String comment) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxHeight: blogName == User.blogName
                ? Sizing.blockSizeVertical * 15
                : Sizing.blockSizeVertical * 30),
        context: context,
        builder: (BuildContext context) {
          if (blogName == User.blogName) {
            return GetBuilder<NotesController>(
                builder: (controller) => Column(
                      children: [
                        buildModalSheetTile('Copy', () {
                          Clipboard.setData(ClipboardData(text: comment));
                          Get.back();
                        }),
                        buildModalSheetTile('Reply', () {
                          controller.addStringToComment('@' + blogName + ' ');
                          Get.back();
                        }),
                      ],
                    ));
          } else {
            return GetBuilder<NotesController>(
                builder: (controller) => Column(
                      children: [
                        buildModalSheetTile('Copy', () {
                          Clipboard.setData(ClipboardData(text: comment));
                          Get.back();
                        }),
                        buildModalSheetTile('Reply', () {
                          controller.addStringToComment('@' + blogName + ' ');
                          Get.back();
                        }),
                        buildModalSheetTile('Report', () {
                          print('Report');
                          Get.back();
                        }),
                        buildModalSheetTile('Block ' + blogName, () {
                          print('Block');
                          Get.back();
                        }),
                      ],
                    ));
          }
        });
  }

  Future<void> getReblogsModalSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: Sizing.blockSizeVertical * 30),
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<NotesController>(
              builder: (controller) => Obx(
                    () => Column(
                      children: [
                        SizedBox(height: Sizing.blockSizeVertical * 4.5),
                        InkWell(
                          onTap: () {
                            if (!controller.reblogsWithComments.value) {
                              controller.reblogsWithComments.value = true;
                            }
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                Sizing.blockSize * 2.91, 0, 0, 0),
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
                                          fontWeight: FontWeight.bold,
                                        ),
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

  Future<void> getReblogsWithCommentsModalSheet(
      BuildContext context, String blogName, String comment) {
    return showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: Sizing.blockSizeVertical * 30),
        context: context,
        builder: (BuildContext context) {
          if (blogName == User.blogName) {
            return GetBuilder<NotesController>(
                builder: (NotesController controller) => Column(
                      children: [
                        buildModalSheetTile('Reblog', () {
                          controller.reblogFromNotes();
                        }),

                        // TODO: Might change this to 'go to user profile'
                        buildModalSheetTile('View Post', () {
                          print('view post');
                        }),
                      ],
                    ));
          } else {
            return GetBuilder<NotesController>(
                builder: (controller) => Column(
                      children: [
                        buildModalSheetTile('Reblog', () {
                          print('reblog');
                        }),
                        buildModalSheetTile('View Post', () {
                          print('view post');
                        }),
                        buildModalSheetTile('Report', () {
                          print('Report');
                          Get.back();
                        }),
                        buildModalSheetTile('Block ' + blogName, () {
                          print('Block');
                          Get.back();
                        }),
                      ],
                    ));
          }
        });
  }
}
