import 'dart:convert';

import '../../models/cmplr_service.dart';

import '../../backend_uris.dart';
import 'package:get/get.dart';

import '../home_tab/write_post_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/controllers.dart';
import '../../utilities/sizing/sizing.dart';
import 'utility_views.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

/// A custom app bar to insure the size limits
class CustomAppBar extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBar({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key, child: child, preferredSize: Size.fromHeight(height));

  @override
  Widget build(BuildContext context) => child;
}

/// the post feed of the hashtags
class HashtagPosts extends StatelessWidget {
  const HashtagPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HashtagPostsController(),
      builder: (HashtagPostsController controller) => WillPopScope(
        onWillPop: () {
          try {
            Get.delete<PostFeedController>(tag: 'HashTagPostsRecent');
            Get.delete<PostFeedController>(tag: 'HashTagPostsTop');
          } catch (e) {
            e.printError();
          }
          Get.back();
          return Future.value(true);
        },
        child: Scaffold(
          // FIXME: pass tags to the write post controller
          floatingActionButton: FloatingActionButton(
            key: const ValueKey('masterPage_write_post'),
            child: const Icon(Icons.edit),
            onPressed: () {
              Get.to(
                const WritePost(),
                transition: Transition.downToUp,
              );
            },
            backgroundColor: Colors.blue,
          ),
          body: FutureBuilder(
              future: CMPLRService.get(
                  GetURIs.tagInfo, {'tag': controller.tagName}),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final response = jsonDecode(snapshot.data.body) ?? [];
                  controller.hashtagFollowed.value = response['is_follower'];
                  controller.tagAvatar = response['tag_avatar'];
                  return ExtendedNestedScrollView(
                    headerSliverBuilder: (context, f) {
                      return <Widget>[
                        SliverAppBar(
                          backgroundColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          pinned: true,
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          actions: [
                            IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.showShareMenu(context);
                              },
                            ),
                          ],
                          expandedHeight: Sizing.blockSizeVertical * 32.7,
                          title: Text(
                            '#' + controller.tagName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                              background: Stack(children: [
                            Stack(fit: StackFit.expand, children: <Widget>[
                              Image.network(
                                controller.tagAvatar ??
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ]),
                            Positioned(
                              child: Row(
                                children: [
                                  Obx(() => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            primary: Colors.purple),
                                        child: controller.hashtagFollowed.value
                                            ? const Text('Unfollow')
                                            : const Text('Follow'),
                                        onPressed: () {
                                          controller
                                              .followHashtagButtonPressed();
                                        },
                                      )),
                                  SizedBox(
                                    width: Sizing.blockSize * 2,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        primary: Colors.purple),
                                    child: const Text('New Post'),
                                    onPressed: () {
                                      controller.writePostWithTag();
                                    },
                                  ),
                                ],
                              ),
                              bottom: Sizing.blockSizeVertical * 7.32,
                              left: Sizing.blockSize * 4.86,
                            ),
                          ])),
                          bottom: CustomAppBar(
                            height: Sizing.blockSizeVertical * 7.5,
                            child: Material(
                              color: Colors.purple,
                              child: InkWell(
                                onTap: () {},
                                child: TabBar(
                                  controller: controller.tabController,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: Colors.white,
                                  tabs: [
                                    const Tab(
                                      child: Center(
                                          child: Text(
                                        'Recent',
                                      )),
                                    ),
                                    const Tab(
                                      child: Center(
                                          child: Text(
                                        'Top',
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: Column(
                      children: <Widget>[
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: <Widget>[
                              PostFeed(
                                getTag: 'HashTagPostsRecent',
                                postFeedTypePage: GetURIs.hashtagPosts,
                                tag: controller.tagName.replaceFirst('#', 'to'),
                                prefix: 'Recent' + controller.tagName,
                              ),
                              PostFeed(
                                getTag: 'HashTagPostsTop',
                                postFeedTypePage: GetURIs.hashtagPosts,
                                tag: controller.tagName.replaceFirst('#', 'to'),
                                prefix: 'Top' + controller.tagName,
                              ),
                            ],
                          ),
                        ),
                      ],
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
        ),
      ),
    );
  }
}
