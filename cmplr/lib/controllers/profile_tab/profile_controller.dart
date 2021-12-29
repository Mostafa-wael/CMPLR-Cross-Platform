import 'dart:convert';
import 'dart:io';

import '../../utilities/functions.dart';

import '../../models/cmplr_service.dart';

import '../../utilities/user.dart';

import '../../cmplr_theme.dart';

import '../../views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/models.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _model =
      ModelProfile(blogId: GetStorage().read('user')['primary_blog_id']);

  final _searchModel = ProfileSearchModel();

  final titleController = TextEditingController();
  final descCrontroller = TextEditingController();

  var blogInfo,
      _blogName,
      _blogTitle,
      _blogAvatar,
      _blogAvatarShape,
      _description,
      _backgroundColor,
      _headerImage,
      _url;
  var _currentColor;

  static const clrs = {
    'white': Colors.white,
    'black': Colors.black,
    'green': Colors.green,
    'blue': Colors.blue,
    'red': Colors.red,
    'yellow': Colors.yellow,
    'grey': Colors.grey,
    'brown': Colors.brown,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'orange': Colors.orange,
    'amber': Colors.amber,
    'purple': Colors.purple,
    'indigo': Colors.indigo,
  };

  var _pickedHeader;
  var _pickedAvatar;
  var loaded = 0;
  var _extension;
  var _newHeaderUrl, _newAvatarUrl;

  void incLoaded() {
    loaded++;
  }

  final ImagePicker _picker = ImagePicker();

  dynamic get blogName => _blogName;
  dynamic get blogTitle => _blogTitle;
  dynamic get blogAvatar => _blogAvatar;
  dynamic get blogAvatarShape => _blogAvatarShape;
  dynamic get headerImage => _headerImage;
  dynamic get description => _description;
  dynamic get backgroundColor => _backgroundColor;
  dynamic get url => _url;
  dynamic get currentColor => _currentColor;

  var allowSubmissions = false;
  var ask = false;
  var useMedia = false;
  var topPosts = false;
  var optimizeVideo = false;
  var showUploadProg = false;
  var disableDoubleTapToLike = false;
  bool trueBlue = User.userMap['theme'] == 'trueBlue';
  bool darkMode = User.userMap['theme'] != 'trueBlue';
  TextEditingController changeNameController = TextEditingController();

  List<Blog>? followingBlogs;

  Future<void> goToSettings() async {
    Get.to(const ProfileSettingsView());
    update();
  }

  Future<void> goToChangeName() async {
    Get.to(const ChangeNameView());
    update();
  }

  final List popupMenuChoices = [
    'Share',
    'Get notifications',
    'Block',
    'Report',
    'Unfollow'
  ];

  Future<void> getBlogInfo() async {
    blogInfo = await _model.getBlogInfo();
    if (blogInfo != null) {
      _blogTitle = blogInfo['title'];
      _blogName = blogInfo['blog_name'];
      _blogAvatar = blogInfo['avatar'];
      _blogAvatarShape = blogInfo['avatar_shape'];
      _headerImage =
          blogInfo['header_image'] ?? 'https://via.placeholder.com/150';
      _description = blogInfo['description'] ?? '';
      _backgroundColor = clrs[blogInfo['background_color']];
      _url = blogInfo['url'];
    } else
      throw Exception('Null blog info');
  }

  Future<void> share(BuildContext context) async {
    await Share.share(_url);
    update();
  }

  Future<void> shareFollowing(BuildContext context, String blogURL) async {
    await Share.share(blogURL);
    update();
  }

  Future<void> goBack() async {
    Get.back();
    update();
  }

  Future<void> goToEdit() async {
    _currentColor = backgroundColor;
    titleController.text = blogTitle;
    descCrontroller.text = description;
    Get.to(const EditProfileView());
    update();
  }

  // TODO: Integrate whatever of these the back implements
  Future<void> toggleSubmissions() async {
    allowSubmissions = !allowSubmissions;
    update();
  }

  Future<void> toggleUseMedia() async {
    useMedia = !useMedia;
    update();
  }

  Future<void> toggleAsk() async {
    ask = !ask;
    update();
  }

  Future<void> toggleShowTopPosts() async {
    topPosts = !topPosts;
    update();
  }

  Future<void> toggleDisableDoubleTapToLike() async {
    disableDoubleTapToLike = !disableDoubleTapToLike;
    update();
  }

  Future<void> toggleOptimizeVids() async {
    optimizeVideo = !optimizeVideo;
    update();
  }

  Future<void> toggleShowUploadProg() async {
    showUploadProg = !showUploadProg;
    update();
  }

  Future<void> goToAccountSettings() async {
    Get.to(const AccountSettingsView());
    update();
  }

  Future<void> changeColor(String key) async {
    _currentColor = clrs[key];
    update();
  }

  Future<void> pickHeader() async {
    _pickedHeader =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (_pickedHeader != null) {
      _extension = _pickedHeader.name.split('.')[1];
      _pickedHeader = File(_pickedHeader.path).readAsBytesSync();
      final temp = base64Encode(_pickedHeader);
      _pickedHeader = 'data:image/${_extension};base64,' + temp.toString();
    }
  }

  Future<void> pickAvatar() async {
    _pickedAvatar =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (_pickedAvatar != null) {
      _extension = _pickedAvatar.name.split('.')[1];
      _pickedAvatar = File(_pickedAvatar.path).readAsBytesSync();
      final temp = base64Encode(_pickedAvatar);
      _pickedAvatar = 'data:image/${_extension};base64,' + temp.toString();
    }
  }

  Future<dynamic> getImgUrl(bool header) async {
    final response;
    if (header)
      response = await _model.uploadImg(_pickedHeader);
    else
      response = await _model.uploadImg(_pickedAvatar);
    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    if (header)
      _newHeaderUrl = responseMap['response']['url'];
    else
      _newAvatarUrl = responseMap['response']['url'];
    final response1 = await saveEdits(false);
  }

  Future<dynamic> saveEdits(visibleKeyboard) async {
    final response = await _model.putBlogSettings(
      nameClrs[_currentColor ?? _backgroundColor],
      titleController.text == '' ? _blogTitle : titleController.text,
      descCrontroller.text == '' ? description : descCrontroller.text,
      _newHeaderUrl ?? _headerImage,
      _newAvatarUrl ?? _blogAvatar,
      changeNameController.text == '' ? _blogName : changeNameController.text,
    );

    await getBlogInfo();
    Get.back();
    if (visibleKeyboard) Get.back();
    update();
    _newHeaderUrl = _headerImage;
    _newAvatarUrl = _blogAvatar;
    _currentColor = _backgroundColor;
    titleController.text = _blogTitle;
    descCrontroller.text = _description;
    changeNameController.text = _blogName;

    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    return responseMap['response'];
  }

  Future<void> getFollowingBlogs() async {
    followingBlogs = await _searchModel.getFollowingBlogs();
  }

  Future<void> setTrueBlue() async {
    final response = await _model.putTheme('trueBlue');
    if (response.statusCode == CMPLRService.requestSuccess) {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(CMPLRTheme.trueBlue());
      User.userMap['theme'] = 'trueBlue';
      trueBlue = true;
      darkMode = false;
      update();
    }
  }

  Future<void> setDarkMode() async {
    final response = await _model.putTheme('darkMode');
    if (response.statusCode == CMPLRService.requestSuccess) {
      User.userMap['theme'] = 'darkMode';
      trueBlue = false;
      darkMode = true;
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(CMPLRTheme.darkTheme());
      update();
    }
  }

  Future<void> goToColorPalette() async {
    Get.to(const ColorPaletteView());
    update();
  }

  static var nameClrs = {
    Colors.white: 'white',
    Colors.black: 'black',
    Colors.green: 'green',
    Colors.blue: 'blue',
    Colors.red: 'red',
    Colors.yellow: 'yellow',
    Colors.grey: 'grey',
    Colors.brown: 'brown',
    Colors.pink: 'pink',
    Colors.teal: 'teal',
    Colors.cyan: 'cyan',
    Colors.orange: 'orange',
    Colors.amber: 'amber',
    Colors.purple: 'purple',
    Colors.indigo: 'indigo',
  };
}
