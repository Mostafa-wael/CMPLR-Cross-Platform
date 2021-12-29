import '../../../routes.dart';

import '../../../utilities/sizing/sizing.dart';

import '../../../controllers/utilities/post_feed_controller.dart';

import '../../../controllers/blog/blog_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class VisitorBlog extends StatelessWidget {
  VisitorBlog({Key? key, required this.blogId}) : super(key: key);

  final String blogId;
  final double coverHight = 280.0;
  final double profileHeight = 144.0;

  final blogController = Get.put(BlogController(), tag: 'BlogController');
  @override
  Widget build(BuildContext context) {
    final top = coverHight - profileHeight / 2;
    final bottom = profileHeight / 2;
    final _scrollController = ScrollController();

    Sizing.width = MediaQuery.of(context).size.width;
    Sizing.height = MediaQuery.of(context).size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    final postController =
        Get.put(PostFeedController(postFeedTypeFeed: Routes.homeTab));
    postController.updatePosts();

    blogController.fetchBlogInfo(blogId);

    return Obx(() => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _visitorBlogAppBar(blogController),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent / 3)
              blogController.scrolledDown(true);
            else if (_scrollController.position.pixels <
                _scrollController.position.maxScrollExtent / 3)
              blogController.scrolledDown(false);

            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _profileAndCoverStackWidget(
                    bottom, context, blogController, top),
                const SizedBox(
                  height: 10,
                ),
                // Profile Name
                Text(
                  blogController.isBlogInfoLoading.value
                      ? ''
                      : blogController.blogInfo!.value.name!,
                  style: const TextStyle(fontSize: 20),
                ),

                _postsWidget(context, postController)
              ],
            ),
          ),
        )));
  }

  MediaQuery _postsWidget(
      BuildContext context, PostFeedController postFeedController) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: !postFeedController.isLoading.value
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: postFeedController.posts.length,
              itemBuilder: (context, index) => postFeedController.posts[index])
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Stack _profileAndCoverStackWidget(double bottom, BuildContext context,
      BlogController blogController, double top) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: _buildCoverImage(context)),
        Obx(
          () => blogController.scrolledDown.value
              ? Container()
              : Positioned(top: top, child: _buildProfilePic(context)),
        )
      ],
    );
  }

  AppBar _visitorBlogAppBar(BlogController blogController) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor:
          blogController.scrolledDown.value ? Colors.black : Colors.transparent,
      title: Text(
        blogController.blogInfo?.value.name ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            )),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Follow',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget _buildCoverImage(BuildContext context) => Container(
      color: Colors.grey,
      child: Image.network(
        'https://www.fcbarcelona.com/fcbarcelona/photo/2020/02/24/3f1215ed-07e8-47ef-b2c7-8a519f65b9cd/mini_UP3_20200105_FCB_VIS_View_1a_Empty.jpg',
        width: double.infinity,
        height: coverHight,
        fit: BoxFit.cover,
      ));

  Widget _buildProfilePic(BuildContext context) => CircleAvatar(
      backgroundColor: Colors.grey.shade800,
      radius: profileHeight / 2,
      backgroundImage: blogController.isBlogInfoLoading.value
          ? const NetworkImage(
              'https://s.hs-data.com/bilder/spieler/gross/211506.jpg')
          : NetworkImage(blogController.blogInfo!.value.avatar!));
}
