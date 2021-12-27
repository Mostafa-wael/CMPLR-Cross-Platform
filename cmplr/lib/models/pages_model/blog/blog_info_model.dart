import 'theme_model.dart';

class BlogInfo {
  String? title;
  String? avatar;
  int? posts;
  String? name;
  String? url;
  int? updated;
  String? description;
  bool? ask;
  bool? askAnon;
  int? likes;
  bool? isBlockedFromPrimary;
  Theme? theme;

  BlogInfo(
      {this.title,
      this.avatar,
      this.posts,
      this.name,
      this.url,
      this.updated,
      this.description,
      this.ask,
      this.askAnon,
      this.likes,
      this.isBlockedFromPrimary,
      this.theme});

  BlogInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    avatar = json['avatar'];
    posts = json['posts'];
    name = json['name'];
    url = json['url'];
    updated = json['updated'];
    description = json['description'];
    ask = json['ask'];
    askAnon = json['ask_anon'];
    likes = json['likes'];
    isBlockedFromPrimary = json['is_blocked_from_primary'];
    theme = json['theme'] == null ? null : Theme.fromJson(json['theme']);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['title'] = title;
    data['avatar'] = avatar;
    data['posts'] = posts;
    data['name'] = name;
    data['url'] = url;
    data['updated'] = updated;
    data['description'] = description;
    data['ask'] = ask;
    data['ask_anon'] = askAnon;
    data['likes'] = likes;
    data['is_blocked_from_primary'] = isBlockedFromPrimary;
    if (theme != null) data['theme'] = theme?.toJson();
    return data;
  }
}
