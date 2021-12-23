import 'dart:convert';

import 'custom_widgets.dart';
import '../../controllers/controllers.dart';
import 'post_sched_menu.dart';
import '../sizing/sizing.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WritePostOrReblog extends StatelessWidget {
  final model;
  final WritePostController controller;
  const WritePostOrReblog(this.model, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizing.blockSizeVertical * 9,
          leading: IconButton(
            icon: Icon(Icons.close, //TODO: Make the color according to theme
                size: Sizing.blockSize * 5,
                color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            ActionChip(
              label: controller.getPostOrReblog(),
              onPressed: () {
                // If the post was created/reblogged successfully
                // Close the write post / reblog view.
                controller.postOrReblog().then((bool insertSuccess) {
                  if (insertSuccess) Get.back();
                });
              },
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  //TODO: Make the color according to thetme
                  color: Colors.white,
                  onPressed: () {
                    roundedModalSheet(
                        context, scheduleMenu(context), 'Post options');
                  },
                  icon: Icon(Icons.more_vert, size: Sizing.blockSize * 5)),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Sizing.blockSizeVertical * 4),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Sizing.blockSizeVertical,
                    horizontal: Sizing.blockSize * 4),
                child: UserNameAvatar()),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          primary: true,
          children: [
            SizedBox(
              height: controller.postHeight,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(height: Sizing.blockSize * 1.2),

                  // The main difference between a post and a reblog
                  if (controller is ReblogController)
                    Padding(
                      padding: EdgeInsets.all(Sizing.blockSize * 3),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: Sizing.blockSize / 20)),
                        child: PostItem(
                          postData: controller.post!.postData,
                          postID: controller.post!.postID,
                          reblogKey: controller.post!.reblogKey,
                          name: controller.post!.name,
                          hashtags: controller.post!.hashtags,
                          numNotes: controller.post!.numNotes,
                          profilePhoto: controller.post!.profilePhoto,
                          showBottomBar: false,
                          isLiked: controller.post!.isLiked,
                        ),
                      ),
                    ),

                  // TextField(
                ],
              ),
            ),
            Expanded(
              child: HtmlEditor(
                otherOptions: OtherOptions(height: controller.editorHeight),
                htmlEditorOptions: const HtmlEditorOptions(
                    shouldEnsureVisible: true,
                    adjustHeightForKeyboard: true,
                    hint: 'Add something, if you\'d line'),
                htmlToolbarOptions: HtmlToolbarOptions(
                    mediaUploadInterceptor:
                        (PlatformFile file, InsertFileType type) async {
                      if (type == InsertFileType.image) {
                        final base64Data =
                            base64.encode(file.bytes!).toString();
                        final base64Image =
                            '''<img src="data:image/${file.extension};base64,$base64Data" data-filename="${file.name}" width="${Sizing.blockSize * 80}"/>''';
                        controller.editorController.insertHtml(base64Image);
                      } else if ({InsertFileType.video, InsertFileType.audio}
                          .contains(type)) {
                        // Do nothing
                      }
                      return false;
                    },
                    renderBorder: false,
                    separatorWidget: const Divider(),
                    defaultToolbarButtons: [
                      const StyleButtons(),
                      const FontSettingButtons(fontSizeUnit: false),
                      const FontButtons(
                          subscript: false,
                          superscript: false,
                          underline: false,
                          clearAll: false),
                      const ColorButtons(highlightColor: false),
                      const InsertButtons(
                          link: true,
                          picture: true,
                          video: true,
                          hr: false,
                          table: false,
                          audio: false)
                    ],
                    customToolbarButtons: [
                      IconButton(
                          icon: const Icon(Icons.tag),
                          onPressed: () {
                            roundedModalSheet(context, addTags(), 'Add tags',
                                maxHeightPercentage: 25.0);
                          })
                    ],
                    toolbarPosition: ToolbarPosition.belowEditor),
                controller: controller.editorController,
              ),
            ),
          ],
        ),
        // TODO: Swap this out to the text editing bottom bar when text
        // is highlighted
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  void roundedModalSheet(BuildContext context, Widget widget, String title,
      {double maxHeightPercentage = 60}) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          // TODO: Make this variable according to schedule
          maxHeight: Sizing.blockSizeVertical * maxHeightPercentage),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizing.blockSize * 5)),
      builder: (BuildContext context) {
        return GetBuilder<WritePostController>(
            builder: (controller) => Column(
                  children: [
                    // TODO: Add the bar at the very top
                    //(don't know which icon)
                    SizedBox(height: Sizing.blockSizeVertical * 3),
                    Container(
                      width: Sizing.blockSize * 12,
                      height: Sizing.blockSize * 1,
                      //TODO: Link this to theme
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizing.blockSize))),
                    ),
                    SizedBox(height: Sizing.blockSizeVertical * 3),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: Sizing.fontSize * 4.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizing.blockSize * 4),
                              child: InkWell(
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: Sizing.fontSize * 4,
                                    // TODO: Link this to theme
                                    fontWeight: FontWeight.w400,
                                    color: Colors.cyan[400],
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    widget
                  ],
                ));
      },
    );
  }

  Widget scheduleMenu(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: Sizing.blockSizeVertical * 3,
        ),
        postOption(
            'Post Now', Icons.edit, controller.isActivated(PostOptions.postNow),
            () {
          controller.setPostOption(PostOptions.postNow);
        }),
        SizedBox(height: Sizing.blockSizeVertical * 3),
        postOption('Save as draft', Icons.drafts_outlined,
            controller.isActivated(PostOptions.saveAsDraft), () {
          controller.setPostOption(PostOptions.saveAsDraft);
        }),
        SizedBox(height: Sizing.blockSizeVertical * 3),
        postOption('Post privately', Icons.lock_outline,
            controller.isActivated(PostOptions.postPrivately), () {
          controller.setPostOption(PostOptions.postPrivately);
        }),
        SizedBox(height: Sizing.blockSizeVertical * 3),
        controller.isActivated(PostOptions.saveAsDraft) ||
                controller.isActivated(PostOptions.postPrivately)
            ? Container()
            : shareToTwitter(
                controller.isActivated(PostOptions.shareToTwitter), controller),
      ],
    );
  }

  Widget addTags() {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizing.blockSizeVertical * 1,
            horizontal: Sizing.blockSize * 3),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: Sizing.blockSizeVertical * 5, child: const TextField()),
          SizedBox(
              height: Sizing.blockSizeVertical * 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Sizing.blockSizeVertical,
                    horizontal: Sizing.blockSize),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const Chip(label: Text('Bruh')),
                    const Chip(label: Text('AAAAA')),
                    const Chip(label: Text('PAIN')),
                    const Chip(label: Text('MAKE')),
                    const Chip(label: Text('IT')),
                    const Chip(label: Text('STOP')),
                  ],
                ),
              )),
        ]));
  }
}
