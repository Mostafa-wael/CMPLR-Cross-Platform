import '../sizing/sizing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../controllers/controllers.dart';

/// This widget represents the post item with all its data
class PostItem extends StatefulWidget {
  final String postData;
  final String postID;
  final String reblogKey;
  final String name;
  final String profilePhoto;
  final int numNotes;
  final List<String> hashtags;
  final bool showBottomBar;

  // ignore: use_key_in_widget_constructors
  const PostItem(
      {required this.postData,
      required this.postID,
      required this.reblogKey,
      required this.name,
      required this.hashtags,
      required this.numNotes,
      required this.profilePhoto,
      required this.showBottomBar});
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  var controller = Get.put(PostItemController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            getUpperBar(),
            getPostData(),
            getHashtagsBar(),
            if (widget.showBottomBar) getBottomBar(),
          ],
        ),
        onTap: () {
          print('Post Item Clicked');
        },
      ),
    );
  }

  Widget getUpperBar() {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          '${widget.postData}',
        ),
      ),
      title: InkWell(
        onTap: () {
          print('Profile clicked');
        },
        child: Text(
          '${widget.name}',
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

  Widget getPostData() {
    return FittedBox(
      child: Image.asset(
        '${widget.profilePhoto}',
        height: 170,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      fit: BoxFit.fill,
    );
  }

  List<TextSpan> getHashtags(List<String> hashtags) {
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

  Widget getHashtagsBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          children: getHashtags(widget.hashtags),
        ),
      ),
    );
  }

  Widget getBottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: Sizing.fontSize * 3.8),
          ),
          onPressed: () {
            controller.openNotes(widget.numNotes);
            print('Notes clicked');
          },
          child: Text('${widget.numNotes} notes',
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.chat_bubble_outline,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.openNotes(widget.numNotes);
                print('Notes clicked');
              },
            ),
            IconButton(
              icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.share();

                print('Share clicked');
              },
            ),
            IconButton(
              icon: Icon(Icons.loop_rounded,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.reblog(widget);
                print('reblog clicked');
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Theme.of(context).primaryColor),
              onPressed: () {
                controller.lovePost();
                print('Love clicked');
              },
            ),
          ],
        )
      ],
    );
  }
}
