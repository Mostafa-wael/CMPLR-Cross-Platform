import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Blog {
  final avatarURL;
  final avatarShape;
  final blogName;
  final profileTitle;
  final blogURL;
  RxBool following = true.obs;

  Blog(
      {this.avatarURL,
      this.avatarShape,
      this.blogName,
      this.profileTitle,
      this.blogURL,
      required this.following});

  factory Blog.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_bool_literals_in_conditional_expressions
    final followingValue = true.obs;
    return Blog(
        avatarURL: json['avatar'],
        avatarShape: json['avatar_shape'],
        blogName: json['blog_name'],
        profileTitle: json['title'],
        blogURL: json['blog_url'],
        following: followingValue);
  }
}
