class Theme {
  String? avatarShape;
  String? backgroundColor;
  String? bodyFont;
  String? headerImage;
  String? linkColor;
  bool? showAvatar;
  bool? showDescription;
  bool? showHeaderImage;
  bool? showTitle;
  String? titleColor;
  String? titleFont;
  String? titleFontWeight;

  Theme(
      {this.avatarShape,
      this.backgroundColor,
      this.bodyFont,
      this.headerImage,
      this.linkColor,
      this.showAvatar,
      this.showDescription,
      this.showHeaderImage,
      this.showTitle,
      this.titleColor,
      this.titleFont,
      this.titleFontWeight});

  Theme.fromJson(Map<String, dynamic> json) {
    avatarShape = json['avatar_shape'];
    backgroundColor = json['background_color'];
    bodyFont = json['body_font'];
    headerImage = json['header_image'];
    linkColor = json['link_color'];
    showAvatar = json['show_avatar'];
    showDescription = json['show_description'];
    showHeaderImage = json['show_header_image'];
    showTitle = json['show_title'];
    titleColor = json['title_color'];
    titleFont = json['title_font'];
    titleFontWeight = json['title_font_weight'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['avatar_shape'] = avatarShape;
    data['background_color'] = backgroundColor;
    data['body_font'] = bodyFont;
    data['header_image'] = headerImage;
    data['link_color'] = linkColor;
    data['show_avatar'] = showAvatar;
    data['show_description'] = showDescription;
    data['show_header_image'] = showHeaderImage;
    data['show_title'] = showTitle;
    data['title_color'] = titleColor;
    data['title_font'] = titleFont;
    data['title_font_weight'] = titleFontWeight;
    return data;
  }
}
