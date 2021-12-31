import 'package:get_storage/get_storage.dart';

import '../../models/models.dart';
import 'package:getwidget/getwidget.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import '../../backend_uris.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/controllers.dart';
import '../utilities/utility_views.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => FutureBuilder(
          future: controller.getBlogInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                controller.loaded != 0) {
              controller.incLoaded();
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          leading: IconButton(
                            key: const ValueKey('EditProfile_back'),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              controller.goBack();
                            },
                          ),
                          title: Text(
                            'Edit appearance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizing.fontSize * 5,
                            ),
                          ),
                          backgroundColor: controller.currentColor,
                          expandedHeight: Sizing.blockSizeVertical * 60,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Stack(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                  image: controller.headerImage,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: Sizing.blockSizeVertical * 24,
                                  left: Sizing.blockSize * 40,
                                  child:
                                      (controller.blogAvatarShape == 'circle')
                                          ? ClipOval(
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                                image: controller.blogAvatar,
                                                height: Sizing.blockSize * 20,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRect(
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                                image: controller.blogAvatar,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Sizing.blockSize * 4,
                                      Sizing.blockSizeVertical * 6,
                                      Sizing.blockSize * 4,
                                      0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          key: const ValueKey(
                                              'EditProfile_save'),
                                          onTap: () {
                                            controller
                                                .saveEdits(visibleKeyboard);
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    Sizing.fontSize * 4.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  top: Sizing.blockSizeVertical * 36,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ListView(
                                      children: [
                                        TextField(
                                          key: const ValueKey(
                                              'EditProfile_title'),
                                          decoration: const InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          controller:
                                              controller.titleController,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 7,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                (controller.backgroundColor ==
                                                        Colors.white)
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                        TextField(
                                          key: const ValueKey(
                                              'EditProfile_desc'),
                                          decoration: const InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          controller:
                                              controller.descCrontroller,
                                          style: TextStyle(
                                            fontSize: Sizing.fontSize * 3.5,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                (controller.backgroundColor ==
                                                        Colors.white)
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: Sizing.blockSizeVertical * 45,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: Sizing.blockSize * 25,
                                            height:
                                                Sizing.blockSizeVertical * 2.5,
                                            decoration: BoxDecoration(
                                                color: (controller
                                                            .backgroundColor ==
                                                        Colors.blue)
                                                    ? Colors.grey
                                                    : Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Sizing.blockSize * 2))),
                                            child: InkWell(
                                              key: const ValueKey(
                                                  'EditProfile_background'),
                                              onTap: () {
                                                showModalBottomSheet(
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  constraints: BoxConstraints(
                                                    maxHeight: Sizing
                                                            .blockSizeVertical *
                                                        20,
                                                  ),
                                                  builder: (context) {
                                                    return Center(
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          for (var i
                                                              // ignore: lines_longer_than_80_chars
                                                              in ProfileController
                                                                  .clrs.keys)
                                                            InkWell(
                                                              key: ValueKey(
                                                                  'background_'
                                                                  '${i}'),
                                                              child:
                                                                  // ignore: lines_longer_than_80_chars
                                                                  TwoNestedCircles(
                                                                Colors.white,
                                                                // ignore: lines_longer_than_80_chars
                                                                ProfileController
                                                                    .clrs[i],
                                                                // ignore: lines_longer_than_80_chars
                                                                Sizing.blockSize *
                                                                    5,
                                                                // ignore: lines_longer_than_80_chars
                                                                Sizing.blockSize *
                                                                    4,
                                                              ),
                                                              onTap: () {
                                                                controller
                                                                    // ignore: lines_longer_than_80_chars
                                                                    .changeColor(
                                                                        i);
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Background',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: (controller
                                                                // ignore: lines_longer_than_80_chars
                                                                .backgroundColor ==
                                                            Colors.white)
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          forceElevated: innerBoxIsScrolled,
                          bottom: TabBar(
                            indicatorColor:
                                (controller.backgroundColor == Colors.blue)
                                    ? Colors.black
                                    : Colors.blue,
                            tabs: <Tab>[
                              Tab(
                                child: Text(
                                  'Posts',
                                  key: const ValueKey('EditProfile_Posts'),
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Likes',
                                  key: const ValueKey('EditProfile_Likes'),
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Following',
                                  key: const ValueKey('EditProfile_Following'),
                                  style: TextStyle(
                                      color: (controller.backgroundColor ==
                                              Colors.blue)
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: <Widget>[
                        PostFeed(
                          getTag: 'EditProfilePost',
                          blogName: GetStorage().read('user')['blog_name'],
                          postFeedTypePage: GetURIs.postByName,
                          prefix: 'EditProfilePosts',
                        ),
                        PostFeed(
                          getTag: 'EditProfileLike',
                          postFeedTypePage: GetURIs.userLikes,
                          prefix: 'EditProfileLikesRecent',
                        ),
                        FutureBuilder(
                            future: controller.getFollowingBlogs(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done ||
                                  controller.loaded == 0) {
                                return ListView.builder(
                                    itemCount:
                                        controller.followingBlogs!.length,
                                    itemBuilder: (context, index) {
                                      return buildBlogsListTile(
                                          controller.followingBlogs![index],
                                          index,
                                          context,
                                          controller);
                                    });
                              } else {
                                return const Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          }),
    );
  }

  Widget buildBlogsListTile(Blog blog, int index, BuildContext context,
      ProfileController controller) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
        child: Stack(
          children: [
            Row(
              children: [
                blog.avatarShape == 'circle'
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(blog.avatarURL),
                        radius: Sizing.blockSize * 4.45,
                      )
                    : GFAvatar(
                        backgroundImage: NetworkImage(blog.avatarURL),
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
                        blog.blogName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.2,
                            fontWeight: FontWeight.w500,
                            color: Get.theme.textTheme.bodyText1?.color),
                      ),
                      Text(
                        blog.profileTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizing.blockSize * 4.2,
                            fontWeight: FontWeight.w400,
                            color: Get.theme.textTheme.bodyText1?.color),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Sizing.blockSize * 5.9),
              ],
            ),
            Positioned(
              child: Obx(
                () => Center(
                  child: controller.followingBlogs![index].following.value
                      ? PopupMenuButton(
                          icon: const Icon(Icons.person),
                          onSelected: (choice) {
                            print(choice);
                            popupMenuChoiceAction(
                                choice, index, context, controller);
                          },
                          itemBuilder: (context) {
                            return controller.popupMenuChoices.map((choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        )
                      : Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print('Follow button pressed');
                              controller.followingBlogs![index].following
                                  .value = true;
                            },
                            child: Container(
                              height: Sizing.blockSizeVertical * 6.75,
                              padding: EdgeInsets.fromLTRB(
                                  Sizing.blockSize * 2.5,
                                  0,
                                  Sizing.blockSize * 2.5,
                                  0),
                              child: Center(
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                      fontSize: Sizing.blockSize * 4.65,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.lightBlue),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              right: 0,
            ),
          ],
        ),
      ),
    );
  }

  void popupMenuChoiceAction(
      choice, int index, BuildContext context, ProfileController controller) {
    switch (choice) {
      case 'Share':
        {
          controller.shareFollowing(
              context, controller.followingBlogs![index].blogURL);
          break;
        }
      case 'Get notifications':
        {
          break;
        }
      case 'Block':
        {
          break;
        }
      case 'Report':
        {
          break;
        }
      case 'Unfollow':
        {
          print(index);
          controller.followingBlogs![index].following.value = false;
          break;
        }
    }
  }
}
