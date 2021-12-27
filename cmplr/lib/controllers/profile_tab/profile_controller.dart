import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/models.dart';

class ProfileController extends GetxController {
  final _model =
      ModelProfile(blogId: GetStorage().read('user')['primary_blog_id']);

  var blogInfo,
      _blogName,
      _blogTitle,
      _blogAvatar,
      _blogAvatarShape,
      _description,
      _backgroundColor,
      _headerImage,
      _url;

  dynamic get blogName => _blogName;
  dynamic get blogTitle => _blogTitle;
  dynamic get blogAvatar => _blogAvatar;
  dynamic get blogAvatarShape => _blogAvatarShape;
  dynamic get headerImage => _headerImage;
  dynamic get description => _description;
  dynamic get backgroundColor => _backgroundColor;
  dynamic get url => _url;

  Future<void> getBlogInfo() async {
    blogInfo = await _model.getBlogInfo();
    _blogTitle = blogInfo['title'];
    _blogName = blogInfo['blog_name'];
    _blogAvatar = blogInfo['avatar'];
    _blogAvatarShape = blogInfo['avatar_shape'];
    _headerImage = blogInfo['header image'];
    _description = blogInfo['description'];
    _backgroundColor = blogInfo['background_color'];
    _url = blogInfo['url'];
  }
}
