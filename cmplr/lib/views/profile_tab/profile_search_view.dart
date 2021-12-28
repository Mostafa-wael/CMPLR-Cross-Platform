import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../models/models.dart';
import 'package:getwidget/getwidget.dart';

import '../../utilities/user.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSearch extends StatelessWidget {
  ProfileSearch({Key? key}) : super(key: key);

  var controller = Get.put(ProfileSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Row(
        children: [
          IconButton(
              onPressed: () {
                controller.closeSearchPage();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              )),
          SizedBox(
            width: Sizing.blockSize * 2.5,
          ),
          SizedBox(
            width: Sizing.blockSize * 74,
            child: TextField(
              onChanged: (query) {
                controller.searchQueryChanged();
              },
              controller: controller.searchBarController,
              textInputAction: TextInputAction.search,
              onSubmitted: (searchQuery) {},
              cursorColor: Colors.blue,
              style: TextStyle(
                  fontSize: Sizing.fontSize * 5,
                  color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints: BoxConstraints(
                      minHeight: Sizing.blockSizeVertical * 6,
                      minWidth: Sizing.blockSize * 8.65),
                  contentPadding: EdgeInsets.fromLTRB(
                      Sizing.blockSize,
                      Sizing.blockSize * 1.2,
                      Sizing.blockSize,
                      Sizing.blockSize * 1.2),
                  isDense: true,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  hintText: 'Search ${User.blogName}',
                  fillColor: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
          Obx(() => Visibility(
              visible: controller.showClearSearchBarIcon.value,
              child: IconButton(
                splashRadius: 24,
                onPressed: () {
                  controller.searchBarController.text = '';
                  controller.searchQueryChanged();
                },
                icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
              )))
        ],
      ),
      Container(
        color: Colors.white,
        child: Material(
          child: InkWell(
              onTap: () {},
              child: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.orange,
                tabs: <Widget>[
                  Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Text(
                        'Posts',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                  Tab(
                      height: Sizing.blockSizeVertical * 7.5,
                      child: Text(
                        'Following',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              )),
        ),
      ),
      Expanded(
          child: TabBarView(
              controller: controller.tabController,
              children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(Sizing.blockSize * 4.5),
                  child: Text(
                    'Posts a lot about',
                    style: TextStyle(fontSize: Sizing.blockSize * 4.5),
                  ),
                ),
                Obx(() => Padding(
                      padding: EdgeInsets.all(Sizing.blockSize * 4.5),
                      child: Visibility(
                        visible: controller.showClearSearchBarIcon.value,
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            SizedBox(
                              width: Sizing.blockSize * 7,
                            ),
                            SizedBox(
                              width: Sizing.blockSize * 70,
                              child: Text(
                                '${controller.searchQuery}',
                                style:
                                    TextStyle(fontSize: Sizing.blockSize * 4.5),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
            FutureBuilder(
                future: controller.profileSearchModel.getFollowingBlogs(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    controller.followingBlogs = snapshot.data ?? [];
                    controller.showProfiles = List<RxBool>.filled(
                        controller.followingBlogs!.length, true.obs);
                    return ListView.builder(
                        itemCount: controller.followingBlogs!.length,
                        itemBuilder: (context, index) {
                          return buildBlogsListTile(
                              controller.followingBlogs![index],
                              index,
                              context);
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
          ]))
    ])));
  }

  Widget buildBlogsListTile(Blog blog, int index, BuildContext context) {
    return Obx(() => Visibility(
          visible: controller.showProfiles![index].value,
          child: InkWell(
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
              child: Stack(children: [
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
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            blog.profileTitle,
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
                  child: Obx(() => Center(
                      child: controller.followingBlogs![index].following.value
                          ? PopupMenuButton(
                              icon: const Icon(Icons.person),
                              onSelected: (String choice) {
                                print(choice);
                                popupMenuChoiceAction(choice, index, context);
                              },
                              itemBuilder: (context) {
                                FocusScope.of(context).unfocus();
                                return controller.popupMenuChoices
                                    .map((choice) {
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
                                  ))))),
                  right: 0,
                )
              ]),
            ),
          ),
        ));
  }

  void popupMenuChoiceAction(String choice, int index, BuildContext context) {
    switch (choice) {
      case 'Share':
        {
          controller.share(context, controller.followingBlogs![index].blogURL);
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
