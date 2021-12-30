import '../../controllers/controllers.dart';
import '../sizing/sizing.dart';
import '../../views/blog/screens/visitor_blog.dart';
import '../../views/utilities/hashtag_posts_view.dart';
import '../custom_icons/custom_icons.dart';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:flutter_html/flutter_html.dart';

/// This widget represents the post item with all its data
class PostItem extends StatelessWidget {
  final String postData;
  final String postID;
  final String reblogKey;
  final String name;
  final String profilePhoto;
  final int numNotes;
  final List<dynamic> hashtags;
  final bool showBottomBar;
  final bool isMine;
  RxBool isLiked = false.obs;
  final prefix;
  final index;
  var blogId;

  PostItem(
      {Key? key,
      required this.blogId,
      required this.postData,
      required this.postID,
      required this.reblogKey,
      required this.name,
      required this.hashtags,
      required this.numNotes,
      required this.profilePhoto,
      required this.showBottomBar,
      required this.isMine,
      required this.isLiked,
      required this.prefix,
      required this.index})
      : super(key: key);
  final controller = Get.put(PostItemController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        key: ValueKey('${prefix}_post_${index.toString()}'),
        child: Column(
          children: <Widget>[
            getUpperBar(context),
            getPostData(context),
            getHashtagsBar(context),
            if (showBottomBar) getBottomBar(context),
          ],
        ),
        onTap: () {
          print('Post Item Clicked');
        },
      ),
    );
  }

  Widget getUpperBar(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      leading: Image.network('${profilePhoto}'),
      title: InkWell(
        key: ValueKey('${prefix}_postName_${index.toString()}'),
        onTap: () {
          print('Profile clicked');
          Get.to(VisitorBlog(blogId: blogId, blogName: name));
        },
        child: Text(
          '${name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Get.theme.textTheme.bodyText1?.color,
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz, color: Colors.grey),
        onPressed: () {
          getPostModalSheet(context);
          print('More Options clicked');
        },
      ),
    );
  }

  Widget getPostData(BuildContext context) {
    return FittedBox(
      key: ValueKey('${prefix}_postData_${index.toString()}'),
      child: SingleChildScrollView(
        child: Html(
          data: '${postData}',
          style: {
            '*': Style(color: Get.theme.textTheme.bodyText1?.color),
          },
        ),
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
                Get.to(const HashtagPosts(), arguments: hashtag);
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
          key: ValueKey('${prefix}_postNotes_${index.toString()}'),
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: Sizing.fontSize * 3.8),
          ),
          onPressed: () {
            controller.openNotes(this);
          },
          child: Text('${numNotes} notes',
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            IconButton(
              key: ValueKey('${prefix}_postShare_${index.toString()}'),
              icon: Icon(Icons.share, color: Get.theme.iconTheme.color),
              onPressed: () {
                shareMenu(null, controller, context, profilePhoto, name);
              },
            ),
            IconButton(
              key: ValueKey('${prefix}_postComments_${index.toString()}'),
              icon: Icon(CustomIcons.comment, color: Get.theme.iconTheme.color),
              onPressed: () {
                controller.openNotes(this);
                print('Notes clicked');
              },
            ),
            IconButton(
              key: ValueKey('${prefix}_postLike_${index.toString()}'),
              icon: Icon(CustomIcons.reblog, color: Get.theme.iconTheme.color),
              onPressed: () {
                controller.reblog(this);
                print('reblog clicked');
              },
            ),
            Obx(() => IconButton(
                  key: ValueKey('${prefix}_postLike_${index.toString()}'),
                  icon: Icon(
                      isLiked.value ? Icons.favorite : CupertinoIcons.heart,
                      color: Get.theme.iconTheme.color),
                  onPressed: () {
                    isLiked.value = !isLiked.value;
                    controller.loveClicked(
                        isLiked.value, postID); // keep it after the toggling
                    print('Love state: ${isLiked.value}');
                  },
                )),
          ],
        )
      ],
    );
  }

  Future<void> getPostModalSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxHeight: isMine == true
                ? Sizing.blockSizeVertical * 22.5
                : Sizing.blockSizeVertical * 30),
        context: context,
        builder: (BuildContext context) {
          if (isMine) {
            return GetBuilder<PostItemController>(
                builder: (controller) => Column(
                      children: [
                        buildModalSheetTile('Pin post', () {
                          print('Pin post');
                          Get.back();
                        }),
                        buildModalSheetTile('Mute notifications', () {
                          print('Mute notifications');
                          Get.back();
                        }),
                        buildModalSheetTile('Copy link', () {
                          print('Copy link');
                          Get.back();
                        }),
                      ],
                    ));
          } else {
            return GetBuilder<PostItemController>(
                builder: (controller) => Column(
                      children: [
                        buildModalSheetTile('Report sensitive content', () {
                          print('Report sensitive content');
                          Get.back();
                        }),
                        buildModalSheetTile('Report spam', () {
                          print('Report spam');
                          Get.back();
                        }),
                        buildModalSheetTile('Report something else', () {
                          print('Report something else');
                          Get.back();
                        }),
                        buildModalSheetTile('Copy link', () {
                          print('Copy link');
                          Get.back();
                        }),
                      ],
                    ));
          }
        });
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
              style: TextStyle(fontSize: Sizing.fontSize * 3.89),
            )),
      ),
    );
  }

  factory PostItem.fromJson(Map<String, dynamic> json, prefix, index) {
    final isLikedValue =
        json['post']['is_liked'] == 'true' ? true.obs : false.obs;

    var content = json['post']['content'];

    // Remove raw base64 posts to avoid crashing
    if (RegExp(r'<.*(data:image\/)*;base64,.*>').allMatches(content).length > 0)
      content = json['post']['content']
          .replaceAll(RegExp(r'<.*(data:image\/)*;base64,.*>'), '');

    return PostItem(
      blogId: json['blog']['blog_id'].toString(),
      isMine: json['post']['is_mine'],
      postData: content,
      postID: json['post']['post_id'].toString(),
      reblogKey: "$json['post']['post_id']",
      numNotes: json['post']['notes_count'],
      hashtags: json['post']['tags'] ?? [],
      name: json['blog']['blog_name'],
      profilePhoto: json['blog']['avatar'],
      showBottomBar: true,
      isLiked: isLikedValue,
      prefix: prefix,
      index: index,
    );
  }
}
