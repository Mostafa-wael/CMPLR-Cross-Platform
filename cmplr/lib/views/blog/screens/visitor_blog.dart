import '../../../utilities/custom_icons/custom_icons.dart';
import '../../../utilities/custom_widgets/custom_widgets.dart';
import '../../../utilities/sizing/sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../controllers/utilities/post_feed_controller.dart';

import '../../../controllers/blog/blog_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class VisitorBlog extends StatelessWidget {
  VisitorBlog(
      {Key? key,
      required this.postData,
      required this.isLiked,
      required this.name,
      required this.profilePhoto,
      required this.numNotes,
      required this.hashtags})
      : super(key: key);

  final String postData;
  final double coverHight = 280.0;
  final double profileHeight = 144.0;
  RxBool isLiked = false.obs;
  final String name;
  final String profilePhoto;
  final int numNotes;
  final List<dynamic> hashtags;

  @override
  Widget build(BuildContext context) {
    final top = coverHight - profileHeight / 2;
    final bottom = profileHeight / 2;
    final _scrollController = ScrollController();
    final blogController = Get.put(BlogController());

    Sizing.width = MediaQuery.of(context).size.width;
    Sizing.height = MediaQuery.of(context).size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    final postController = Get.put(PostFeedController());
    postController.updatePosts();
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
                const Text(
                  'Yousef Gamal',
                  style: TextStyle(fontSize: 20),
                ),
                //postController.dataReloaded?
                _postsWidget(context, postController)
                //: const Center(
                //child: CircularProgressIndicator(),)
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
      title: const Text(
        'Yousef Gamal',
        style: TextStyle(color: Colors.white),
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
        ),
      );
  Widget _buildProfilePic(BuildContext context) => CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        radius: profileHeight / 2,
        backgroundImage: const NetworkImage(
            'https://s.hs-data.com/bilder/spieler/gross/211506.jpg'),
      );

  Widget _postRetrive(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://s.hs-data.com/bilder/spieler/gross/211506.jpg'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('Yousef Gamal')
                ],
              ),
              const Text('Welcome to CMPLR Blog, it is my Blog'),
            ],
          ),
        ),
      );

  Widget getUpperBar(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          '${postData}',
        ),
      ),
      title: InkWell(
        onTap: () {
          print('Profile clicked');
        },
        child: Text(
          '${name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz, color: Colors.grey),
        onPressed: () {
          //controller.openMoreOptions();
          print('More Options clicked');
        },
      ),
    );
  }

  Widget getPostData(BuildContext context) {
    return FittedBox(
      child: Image.asset(
        '${profilePhoto}',
        height: 170,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      fit: BoxFit.fill,
    );
  }

  List<TextSpan> getHashtags(List<dynamic> hashtags) {
    final hashtagsWidget = <TextSpan>[];
    for (final hashtag in hashtags) {
      hashtagsWidget.add(
        TextSpan(
            text: '#' + hashtag,
            style: TextStyle(
                color: Colors.grey.withOpacity(0.8),
                fontSize: Sizing.fontSize * 5),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print(hashtag);
              }),
      );
      hashtagsWidget.add(
        const TextSpan(
          text: ' ', // do nothing when space is clicked
        ),
      );
    }
    return hashtagsWidget;
  }

  Widget getHashtagsBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          children: getHashtags(hashtags),
        ),
      ),
    );
  }

  Widget getBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: Sizing.fontSize * 3.8),
          ),
          onPressed: () {
            //controller.openNotes(numNotes);
            print('Notes clicked');
          },
          child: Text('${numNotes} notes',
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  constraints: BoxConstraints(
                    maxHeight: Sizing.blockSizeVertical * 90,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Sizing.blockSize * 5)),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          Sizing.blockSize * 4, 0, Sizing.blockSize * 4, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Sizing.blockSizeVertical * 3),
                          Container(
                            width: Sizing.blockSize * 12,
                            height: Sizing.blockSize * 1,
                            //TODO: Link this to theme
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Sizing.blockSize))),
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserNameAvatar(
                                  profilePhoto,
                                  name,
                                  TextStyle(
                                    fontSize: Sizing.fontSize * 5,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(height: Sizing.blockSizeVertical * 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkResponse(
                                child: Column(
                                  children: [
                                    const Icon(Icons.copy),
                                    const Text(
                                      'Copy',
                                    )
                                  ],
                                ),
                                onTap: () {},
                              ),
                              InkResponse(
                                child: Column(
                                  children: [
                                    const Icon(Icons.share),
                                    const Text(
                                      'Other',
                                    )
                                  ],
                                ),
                                onTap: () {
                                  //controller.share(context, 'Test1');
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizing.blockSizeVertical * 4,
                          ),
                          Container(
                              width: Sizing.blockSize * 92,
                              height: Sizing.blockSize * 0.25,
                              color: Colors.white),
                          SizedBox(
                            height: Sizing.blockSizeVertical * 4,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizing.blockSize * 2),
                                ),
                                filled: true,
                                hintStyle: const TextStyle(color: Colors.white),
                                hintText: 'Type in your text',
                                fillColor: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(CustomIcons.comment,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                //controller.openNotes(numNotes);
                print('Notes clicked');
              },
            ),
            IconButton(
              icon: Icon(CustomIcons.reblog,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                print('reblog clicked');
              },
            ),
            Obx(() => IconButton(
                  icon: Icon(
                      isLiked.value ? Icons.favorite : CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    isLiked.value = !isLiked.value;
                  },
                )),
          ],
        )
      ],
    );
  }
}
