import '../functions.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../custom_icons/custom_icons.dart';

import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import '../sizing/sizing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../controllers/controllers.dart';

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
  RxBool isLiked = false.obs;

  PostItem(
      {Key? key,
      required this.postData,
      required this.postID,
      required this.reblogKey,
      required this.name,
      required this.hashtags,
      required this.numNotes,
      required this.profilePhoto,
      required this.showBottomBar,
      required this.isLiked})
      : super(key: key);
  final controller = Get.put(PostItemController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
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
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          '${profilePhoto}',
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
          controller.openMoreOptions();
          print('More Options clicked');
        },
      ),
    );
  }

  Widget getPostData(BuildContext context) {
    return FittedBox(
      child: Image.asset(
        '${postData}',
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
            controller.openNotes(this);
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
                showShareMenu(context, () {
                  controller.share(context, 'Test1');
                });
              },
            ),
            IconButton(
              icon: Icon(CustomIcons.comment,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.openNotes(this);
                print('Notes clicked');
              },
            ),
            IconButton(
              icon: Icon(CustomIcons.reblog,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.reblog(this);
                print('reblog clicked');
              },
            ),
            Obx(() => IconButton(
                  icon: Icon(
                      isLiked.value ? Icons.favorite : CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    isLiked.value = !isLiked.value;
                    controller.loveClicked();
                    print('Love state: ${isLiked.value}');
                  },
                )),
          ],
        )
      ],
    );
  }

  factory PostItem.fromJson(Map<String, dynamic> json) {
    final isLikedValue = json['is_liked'] == 'true' ? true.obs : false.obs;
    return PostItem(
      postData: json['postData'],
      postID: json['postData'],
      reblogKey: json['reblogKey'],
      name: json['name'],
      profilePhoto: json['profilePhoto'],
      numNotes: json['numNotes'],
      hashtags: json['hashtags'],
      showBottomBar: json['showBottomBar'],
      isLiked: isLikedValue,
    );
  }
}
