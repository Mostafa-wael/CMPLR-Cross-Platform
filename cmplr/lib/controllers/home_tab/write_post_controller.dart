import 'package:get_storage/get_storage.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../models/cmplr_service.dart';

import '../../utilities/sizing/sizing.dart';

import '../../models/models.dart';
// import 'package:metadata_fetch/metadata_fetch.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

class PostOptions {
  // postNow
  static const postNow = 'publish';

  // saveAsDraft
  static const String saveAsDraft = 'draft';
  // postPrivately
  static const String postPrivately = 'private';
  // shareToTwitter // Not in the backend

  static const String shareToTwitter =
      'THIS SHOULDN\'T BE HERE, IT\'S NOT THE BACKEND\'S RESPONSIBILITY';
}

class WritePostController extends GetxController {
  HtmlEditorController editorController = HtmlEditorController();
  String _currentPostOption = PostOptions.postNow;

  bool _bold = false;
  bool _italic = false;
  bool _strikethrough = false;

  final allColors = [
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];

  final allColorsNames = [
    'white',
    'red',
    'orange',
    'green',
    'blue',
    'purple',
    'pink',
  ];

  // TODO: Change default color according to theme
  int _currentColor = 0;
  final _userName = 'Username';
  final _userAvatar = 'lib/utilities/assets/logo/logo_icon.png';

  PostItem? post;

  final _model;

  bool tagsAlwaysVisible = false;

  bool showTags(context) =>
      MediaQuery.of(context).viewInsets.bottom == 0 || tagsAlwaysVisible;

  final TextEditingController textController = TextEditingController();

  List<TextField> urls = [];
  List<TextEditingController> urlControllers = [];

  List<Widget> previews = [];

  String get userName => _userName;

  String get userAvatar => _userAvatar;

  Color get currentColor => allColors[_currentColor];

  double get postHeight => post != null ? Sizing.blockSizeVertical * 27 : 0;
  double get editorHeight => Sizing.blockSizeVertical * 82 - postHeight;

  void changeColor(int colorIndex) {
    _currentColor = colorIndex;
    update();
  }

  void toggleBold() {
    _bold = !_bold;
    update();
  }

  void toggleItalic() {
    _italic = !_italic;
    update();
  }

  void toggleStrikethrough() {
    _strikethrough = !_strikethrough;
    update();
  }

  Text getPostOrReblog() {
    // Have a post => Reblogging
    if (post != null)
      return Text(
        'Reblog',
        style: TextStyle(
          fontSize: Sizing.fontSize * 3.5,
          fontWeight: FontWeight.w400,
        ),
      );
    // Otherwise, we're posting
    else
      return Text(
        'Post',
        style: TextStyle(
          fontSize: Sizing.fontSize * 3.5,
          fontWeight: FontWeight.w400,
        ),
      );
  }

  void setPost(PostItem postItem) {
    post = postItem;
  }

  bool get bold => _bold;

  bool get italic => _italic;

  bool get strikethough => _strikethrough;

  String get currentPostOption => _currentPostOption;

  WritePostController(this._model) {
    initializeDateFormatting();
  }

  bool isActivated(String option) {
    return _currentPostOption == option;
  }

  Future<void> setPostOption(String option) async {
    _currentPostOption = option;
    update();
  }

  // AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  // void addLink() {
  //   Future<Metadata?>? fut;
  //   final editingController = TextEditingController();
  //   final textField = TextField(
  //     controller: editingController,
  //     decoration: const InputDecoration(
  //         border: OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.white, width: 5.0))),
  //     onEditingComplete: () {
  //       // previews.add(FlutterLinkPreview(url: editingController.text));
  //       fut = MetadataFetch.extract(editingController.text);
  //     },
  //   );

  //   fut?.then((value) => print(value));

  //   urls.add(textField);
  //   urlControllers.add(editingController);

  //   update();
  // }

  // TODO: Show the created or reblogged post somewhere?
  Future<bool> postOrReblog() async {
    final postText = await editorController.getText();

    // TODO: get the real blog name
    final blogName = GetStorage().read('blog_name') ?? 'tarek';
    const type = 'text';
    const tags = ['test_tag', 'other_test_tag'];

    final http.Response response;
    if (_model is WritePostModel)
      response = await _model.createPost(
        postText,
        blogName,
        type,
        _currentPostOption,
        tags,
      );
    else if (_model is ReblogModel)
      response = await _model.reblogPost(
        post?.postID,
        post?.reblogKey,
        postText,
      );
    else
      throw Exception('Unsupported model');

    return response.statusCode == CMPLRService.insertSuccess;
  }

  // wrap text in needed tags and return it
  String prepareText() {
    // Split into 3 part so we can insert the color more easily
    final tags = [
      ['<b', '>', '</b>'],
      ['<i', '>', '</i>'],
      ['<s', '>', '</s>']
    ];

    final flags = [
      _bold,
      _italic,
      _strikethrough,
    ];

    assert(flags.length == tags.length);

    var postText = textController.text;
    var colored = false;
    for (var i = 0; i < flags.length; i++) {
      if (flags[i]) {
        if (!colored) {
          // Should result in something like
          // <b style="color:red">text</b>
          postText = tags[i][0] +
              ' style="color:${allColorsNames[_currentColor]}"' +
              tags[i][1] +
              postText +
              tags[i][2];

          colored = true;
        } else
          postText = tags[i][0] + tags[i][1] + postText + tags[i][2];
      }
    }
    return postText;
  }
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
