import 'dart:convert';

import '../../views/views.dart';

import '../../backend_uris.dart';
import '../../routes.dart';
import '../../views/utilities/post_sched_menu.dart';

import '../../models/cmplr_service.dart';
import '../../utilities/sizing/sizing.dart';
import '../../models/models.dart';
import '../../views/utilities/utility_views.dart';

import 'package:get_storage/get_storage.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

/// managijg writing and creating a post
class WritePostController extends GetxController {
  HtmlEditorController editorController = HtmlEditorController();
  String _currentPostOption = PostOptions.postNow;

  bool _bold = false;
  bool _italic = false;
  bool _strikethrough = false;

  String _date = DateTime.now().toString();
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final _currentDate = DateTime.now();

  final _model;

  var tagsFocusNode;

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

  TextEditingController textController = TextEditingController();

  PostItem? post;
  bool tagsAlwaysVisible = false;

  bool showTags(context) =>
      MediaQuery.of(context).viewInsets.bottom == 0 || tagsAlwaysVisible;

  // List<TextField> urls = [];
  // List<TextEditingController> urlControllers = [];
  // List<Widget> previews = [];

  List<String> tags = [];
  List suggestedTags = [];
  TextEditingController tagsEditingController = TextEditingController();

  String postType = 'text';

  Color get currentColor => allColors[_currentColor];

  String get date => _date;

  double get postHeight => post != null ? Sizing.blockSizeVertical * 27 : 0;

  double get editorHeight => Sizing.blockSizeVertical * 82 - postHeight;

  bool get bold => _bold;

  bool get italic => _italic;

  bool get strikethough => _strikethrough;

  String get currentPostOption => _currentPostOption;

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
    update();
  }

  WritePostController(this._model) {
    initializeDateFormatting();
    final date_1 = DateFormat.MMMEd().format(_dateTime);
    final date_2 = DateFormat.jm().format(_dateTime);
    _date = '${date_1} at  ${date_2}';

    update();
  }

  bool isActivated(String option) {
    return _currentPostOption == option;
  }

  void setPostOption(String option) {
    _currentPostOption = option;
    update();
  }

  Future<void> setDateTime(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: _currentDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      _dateTime = picked;
      final date_1 = DateFormat.MMMEd().format(_dateTime);
      _date = '${date_1} at ${_date.split('at')[1]}';
      update();
    }
  }

  Future<void> setTimeOfDay(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null && picked != _timeOfDay) {
      if (picked.hour < TimeOfDay.fromDateTime(_currentDate).hour ||
          (picked.hour == TimeOfDay.fromDateTime(_currentDate).hour &&
              picked.minute < TimeOfDay.fromDateTime(_currentDate).minute)) {
        _showToast('Nice try, but you can\'t post from the past.');
      } else {
        _timeOfDay = picked;
        final hour =
            _timeOfDay.hour >= 12 ? _timeOfDay.hour - 12 : _timeOfDay.hour;
        final am = _timeOfDay.hour >= 12 ? 'PM' : 'AM';
        final date_2 = '${hour}:${_timeOfDay.minute}${am}';
        _date = '${_date.split('at')[0]}at ${date_2}';
        update();
      }
    }
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

    var success = false;
    if (_model is WritePostModel) {
      final writePostModel = _model as WritePostModel;
      writePostModel
          .createPost(
        postText,
        blogName,
        postType,
        _currentPostOption,
        tags,
      )
          .then((http.Response response) {
        if (response.statusCode == CMPLRService.insertSuccess) {
          success = true;
          tags.clear();

          Get.back();
        }
      });
    } else if (_model is ReblogModel) {
      final reblogModel = _model as ReblogModel;
      reblogModel
          .reblogPost(
        post!.postID,
        post!.reblogKey,
        postText,
      )
          .then((http.Response response) {
        if (response.statusCode == CMPLRService.insertSuccess) {
          success = true;
          tags.clear();
          Get.back();
        }
      });
    } else
      throw Exception('Unsupported model');

    return success;
  }

  // wrap text in needed tags and return it
  // To be removed
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

  void onTagsSheetOpen() async {
    await CMPLRService.get(GetURIs.getSuggestedTags, {})
        .then((http.Response value) {
      if (value.statusCode == CMPLRService.requestSuccess) {
        final List tagsList = jsonDecode(value.body)['response']['tags'];
        suggestedTags = tagsList.map((e) => e = e['tag_name']).toList();
        update();
      } else
        _showToast('Error occured while fetching suggested tags :(');
    });
  }

  void onTagEnter(String tag) {
    tag = tag.removeAllWhitespace;
    tag = tag.replaceAll('#', '');
    if (tag.length != 0) {
      tags.add(tag);
      update();
    }
  }

  void onTagDeleted(String tag) {
    tags.remove(tag);
    update();
  }

  void onSuggestionChoosen(String suggestion) {
    suggestedTags.remove(suggestion);
    suggestion.replaceAll('#', '');
    tags.add(suggestion);
    update();
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
