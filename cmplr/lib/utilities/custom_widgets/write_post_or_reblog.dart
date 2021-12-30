// ignore_for_file: lines_longer_than_80_chars

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
    return GetBuilder<WritePostController>(
      builder: (WritePostController controller) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
              GetBuilder<WritePostController>(
                builder: (WritePostController controller) => Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      //TODO: Make the color according to the;me
                      color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          constraints: BoxConstraints(
                              // TODO: Make this variable according to schedule
                              maxHeight: Sizing.blockSizeVertical * 60),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Sizing.blockSize * 5),
                          ),
                          builder: (BuildContext context) {
                            return GetBuilder<WritePostController>(
                                builder: (controller) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height:
                                                Sizing.blockSizeVertical * 3),
                                        Container(
                                          width: Sizing.blockSize * 12,
                                          height: Sizing.blockSize * 1,
                                          //TODO: Link this to theme
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Sizing.blockSize))),
                                        ),
                                        SizedBox(
                                            height:
                                                Sizing.blockSizeVertical * 3),
                                        // Menu name and done button
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Post options',
                                                  style: TextStyle(
                                                    fontSize:
                                                        Sizing.fontSize * 4.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          Sizing.blockSize * 4),
                                                  child: InkWell(
                                                    child: Text(
                                                      'Done',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Sizing.fontSize * 4,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.blue,
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
                                        scheduleMenu(context)
                                      ],
                                    ));
                          },
                        );
                      },
                      icon: Icon(Icons.more_vert, size: Sizing.blockSize * 5)),
                ),
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
                            blogId: controller.post?.blogId,
                            postData: controller.post!.postData,
                            postID: controller.post!.postID,
                            reblogKey: controller.post!.reblogKey,
                            name: controller.post!.name,
                            hashtags: controller.post!.hashtags,
                            numNotes: controller.post!.numNotes,
                            profilePhoto: controller.post!.profilePhoto,
                            showBottomBar: false,
                            isLiked: controller.post!.isLiked,
                            isMine: controller.post!.isMine,
                            prefix: 'reblog',
                            index: 0,
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
                          controller.postType = 'photos';
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
                              controller.onTagsSheetOpen();
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizing.blockSize * 5),
                                ),
                                builder: (BuildContext context) {
                                  return GetBuilder<WritePostController>(
                                    builder: (controller) =>
                                        SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height:
                                                    Sizing.blockSizeVertical *
                                                        3),
                                            Container(
                                              width: Sizing.blockSize * 12,
                                              height: Sizing.blockSize * 1,
                                              //TODO: Link this to theme
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          Sizing.blockSize))),
                                            ),
                                            SizedBox(
                                                height:
                                                    Sizing.blockSizeVertical *
                                                        3),
                                            Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Add tags',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Sizing.fontSize *
                                                                4.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        right:
                                                            Sizing.blockSize *
                                                                4,
                                                      ),
                                                      child: InkWell(
                                                        child: Text(
                                                          'Done',
                                                          style: TextStyle(
                                                            fontSize: Sizing
                                                                    .fontSize *
                                                                4,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.blue,
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
                                            SizedBox(
                                              height:
                                                  Sizing.blockSizeVertical * 3,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Sizing.blockSizeVertical *
                                                          1,
                                                  horizontal:
                                                      Sizing.blockSize * 3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  TextField(
                                                    controller: controller
                                                        .tagsEditingController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Enter a tag!'),
                                                    onEditingComplete: () {
                                                      controller.onTagEnter(
                                                          controller
                                                              .tagsEditingController
                                                              .text);
                                                      controller
                                                          .tagsEditingController
                                                          .clear();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: Sizing
                                                            .blockSizeVertical *
                                                        7,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: controller
                                                            .tags.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final tagName =
                                                              controller
                                                                  .tags[index];
                                                          return Chip(
                                                            label:
                                                                Text(tagName),
                                                            deleteIcon:
                                                                const Icon(Icons
                                                                    .cancel),
                                                            // Remove from suggestions and add to included
                                                            onDeleted: () {
                                                              controller
                                                                  .onTagDeleted(
                                                                      tagName);
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: Sizing
                                                            .blockSizeVertical *
                                                        7,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: controller
                                                          .suggestedTags.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final tagName = controller
                                                                .suggestedTags[
                                                            index];
                                                        return Chip(
                                                          label: Text(tagName),
                                                          deleteIcon:
                                                              const Icon(
                                                                  Icons.add),
                                                          // Remove from suggestions and add to included
                                                          onDeleted: () {
                                                            controller
                                                                .onSuggestionChoosen(
                                                                    tagName);
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
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
      ),
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
        scheduleOption(
          controller.isActivated(PostOptions.schedule),
          controller,
          context,
        ),
        SizedBox(height: Sizing.blockSizeVertical * 3),
        postOption(
          'Post privately',
          Icons.lock_outline,
          controller.isActivated(PostOptions.postPrivately),
          () {
            controller.setPostOption(
              PostOptions.postPrivately,
            );
          },
        ),
        SizedBox(height: Sizing.blockSizeVertical * 3),
        controller.isActivated(PostOptions.saveAsDraft) ||
                controller.isActivated(PostOptions.postPrivately)
            ? Container()
            : shareToTwitter(
                controller.isActivated(
                  PostOptions.shareToTwitter,
                ),
                controller,
              ),
      ],
    );
  }
}
