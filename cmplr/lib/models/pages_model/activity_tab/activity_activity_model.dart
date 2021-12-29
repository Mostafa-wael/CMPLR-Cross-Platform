import 'dart:convert';

import '../../../flags.dart';
import '../../../utilities/user.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';

class Notification {
  var id,
      fromBlogId,
      fromBlogName,
      fromBlogAvatar,
      fromBlogAvatarShape,
      toBlogId,
      toBlogName,
      type,
      seen,
      postAskAnswerId,
      postAskAnswerContent,
      doYouFollow,
      createdAt;

  Notification(
      this.id,
      this.fromBlogId,
      this.fromBlogName,
      this.fromBlogAvatar,
      this.fromBlogAvatarShape,
      this.toBlogId,
      this.toBlogName,
      this.type,
      this.seen,
      this.postAskAnswerId,
      this.postAskAnswerContent,
      this.doYouFollow,
      this.createdAt);

  Notification.fromJson(json) {
    id = json['notification_id'];
    fromBlogId = json['from_blog_id'];
    fromBlogName = json['from_blog_name'];
    fromBlogAvatar = json['from_blog_avatar'];
    fromBlogAvatarShape = json['from_blog_avatar_shape'];
    toBlogId = json['to_blog_id'];
    toBlogName = json['to_blog_name'];
    type = json['type'];
    seen = json['seen'];
    postAskAnswerId = json['post_ask_answer_id'];
    postAskAnswerContent = json['post_ask_answer_content'];
    doYouFollow = json['do_you_follow'];
    createdAt = json['created_at'];
  }
}

class ActivityActivityModel {
  static Future<List<Map<String, List<Notification>>>> getActivityNotifications(
      List<String> filterTypes) async {
    final notifs = <Map<String, List<Notification>>>[];

    if (Flags.mock) {
      mockNotifications.forEach((key, value) {
        final date = key as String;
        final dateNotifs = <Notification>[];
        final notifications = value as List;

        notifications.forEach((notification) {
          dateNotifs.add(Notification.fromJson(notification));
        });
        notifs.add({'date': dateNotifs});
      });
    } else {
      final response = await CMPLRService.get(
        GetURIs.activityNotifications,
        {'blog-identifier': User.userMap['id'].toString(), 'type': filterTypes},
      );
      if (response.statusCode == CMPLRService.requestSuccess) {
        // Should return a list of notifications
        final responseBody = jsonDecode(response.body);
        final Map responseMap = responseBody['response'];

        responseMap.forEach((key, value) {
          final date = key as String;
          final dateNotifs = <Notification>[];
          final notifications = value as List;

          notifications.forEach((notification) {
            dateNotifs.add(Notification.fromJson(notification));
          });
          notifs.add({'date': dateNotifs});
        });
      }
    }

    return notifs;
  }

  static const mockNotifications = {
    '27-Dec-21': [
      {
        'notification_id': 9,
        'from_blog_id': 1,
        'from_blog_name': 'yousef',
        'from_blog_avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'from_blog_avatar_shape': 'circle',
        'to_blog_id': 1,
        'to_blog_name': 'yousef',
        'type': 'ask',
        'seen': false,
        'post_ask_answer_id': 13,
        'post_ask_answer_content': '<html> </html>',
        'do_you_follow': true,
        'created_at': '27-Dec-21 23:31:36'
      }
    ],
    '25-Dec-21': [
      {
        'notification_id': 5,
        'from_blog_id': 7,
        'from_blog_name': 'blog3',
        'from_blog_avatar': null,
        'from_blog_avatar_shape': null,
        'to_blog_id': 1,
        'to_blog_name': 'yousef',
        'type': 'answer',
        'seen': false,
        'post_ask_answer_id': 11,
        'post_ask_answer_content': '<html></html>',
        'do_you_follow': true,
        'created_at': '25-Dec-21 02:05:36'
      },
      {
        'notification_id': 1,
        'from_blog_id': 1,
        'from_blog_name': 'yousef',
        'from_blog_avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'from_blog_avatar_shape': 'circle',
        'to_blog_id': 1,
        'to_blog_name': 'yousef',
        'type': 'follow',
        'seen': true,
        'post_ask_answer_id': null,
        'post_ask_answer_content': null,
        'do_you_follow': true,
        'created_at': '25-Dec-21 02:00:27'
      }
    ],
    '24-Dec-21': [
      {
        'notification_id': 7,
        'from_blog_id': 7,
        'from_blog_name': 'blog3',
        'from_blog_avatar': null,
        'from_blog_avatar_shape': null,
        'to_blog_id': 1,
        'to_blog_name': 'yousef',
        'type': 'answer',
        'seen': false,
        'post_ask_answer_id': 12,
        'post_ask_answer_content': '<html></html>',
        'do_you_follow': true,
        'created_at': '24-Dec-21 02:06:41'
      },
      {
        'notification_id': 2,
        'from_blog_id': 1,
        'from_blog_name': 'yousef',
        'from_blog_avatar':
            'https://assets.tumblr.com/images/default_avatar/cone_closed_128.png',
        'from_blog_avatar_shape': 'circle',
        'to_blog_id': 1,
        'to_blog_name': 'yousef',
        'type': 'ask',
        'seen': false,
        'post_ask_answer_id': 9,
        'post_ask_answer_content': '<html> </html>',
        'do_you_follow': true,
        'created_at': '24-Dec-21 02:01:15'
      }
    ]
  };
}
