import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final String postData;
  final String name;
  final String profilePhoto;
  final int numNotes;
  final List<String> hashtags;

  // ignore: use_key_in_widget_constructors
  const PostItem(
      {required this.postData,
      required this.name,
      required this.hashtags,
      required this.numNotes,
      required this.profilePhoto});
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            getUpperBar(widget),
            getPostData(widget, context),
            getHashtagsBar(widget),
            getBottomBar(widget, context)
          ],
        ),
        onTap: () {
          print('Post Item Clicked');
        },
      ),
    );
  }
}

Widget getUpperBar(widget) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    leading: CircleAvatar(
      backgroundImage: AssetImage(
        '${widget.postData}',
      ),
    ),
    title: Text(
      '${widget.name}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    trailing: IconButton(
      icon: const Icon(Icons.more_horiz),
      onPressed: () {
        print('More Options clicked');
      },
    ),
  );
}

Widget getPostData(widget, context) {
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

List<TextSpan> getHashtags(hashtags) {
  final hashtagsWidget = <TextSpan>[];
  for (final hashtag in hashtags) {
    hashtagsWidget.add(
      TextSpan(
          text: '#' + hashtag,
          style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 20),
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

Widget getHashtagsBar(widget) {
  return RichText(
    text: TextSpan(
      children: getHashtags(widget.hashtags),
    ),
  );
}

Widget getBottomBar(widget, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: () {
          print('Notes Clicked');
        },
        child: Text('${widget.numNotes} notes'),
      ),
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              print('chat clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              print('Share clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.loop_rounded),
            onPressed: () {
              print('reblog clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              print('Love clicked');
            },
          ),
        ],
      )
    ],
  );
}
