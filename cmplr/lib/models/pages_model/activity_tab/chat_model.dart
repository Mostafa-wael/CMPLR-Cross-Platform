// ignore: lines_longer_than_80_chars
// ignore_for_file: non_constant_identifier_names, prefer_equal_for_default_values, prefer_single_quotes, unnecessary_string_escapes
import 'dart:math';

import '../../../utilities/user.dart';

import '../../cmplr_service.dart';

import '../../../utilities/custom_widgets/post_item.dart';
import '../../../backend_uris.dart';
import 'dart:convert';

class ChatUser {
  final int blog_id;
  final String blog_name;
  final String avatar;
  final String blog_url;

  ChatUser({
    required this.blog_id,
    required this.blog_name,
    required this.avatar,
    required this.blog_url,
  });
}

//----------------------------------------------------------------
class Message {
  final ChatUser sender;
  final String text;
  final bool isRead;

  Message({
    required this.sender,
    required this.text,
    required this.isRead,
  });

  factory Message.fromJson(
      {required Map<String, dynamic> json,
      required bool outOrIn,
      int index: 0}) {
    return outOrIn // out -> outside the chat, in -> inside the chat
        ? Message(
            sender: ChatUser(
              blog_id: json['blog_data']['blog_id'],
              blog_url: json['blog_data']['blog_url'],
              blog_name: json['blog_data']['blog_name'],
              avatar: json['blog_data']['avatar'],
            ),
            text: json['content'],
            isRead: json['is_read'],
          )
        : Message(
            sender: ChatUser(
              blog_id: json['messages'][index]['from_blog_id'],
              blog_url: json['blog_data']['url'],
              blog_name: json['blog_data']['blog_name'],
              avatar: json['blog_data']['avatar'],
            ),
            text: json['messages'][index]['content'],
            isRead: json['messages'][index]['is_read'],
          );
  }
}

class ModelChatModule {
  static final conversationsList = <Message>[];
  static final conversationMessages = <Message>[];

  static Future<void> getConversationsList() async {
    // the chat menu from outside -> URI: messaging
    final response = await CMPLRService.get(GetURIs.conversationsList,
        {'me': User.userMap['primary_blog_id'].toString()});
    print('primary_blog_id');
    print(User.userMap['primary_blog_id'].toString());
    final responseBody = jsonDecode(response.body);
    print('get chat list');
    if (response.statusCode == CMPLRService.requestSuccess) {
      for (var i = 0; i < responseBody.length; i++) {
        conversationsList.add(
          Message.fromJson(json: responseBody[i], outOrIn: true),
        );
      }
    }
  }

  static Future<void> getConversationMessages(int other_blog_id) async {
    // inside the chat itself -> URI: conversation
    final response = await CMPLRService.get(GetURIs.conversationMessages, {
      'me': User.userMap['primary_blog_id'].toString(),
      'to': other_blog_id.toString()
    });
    final responseBody = jsonDecode(response.body);
    print('get chats message');
    print('primary_blog_id and the other');
    print(User.userMap['primary_blog_id'].toString());
    print(other_blog_id.toString());
    if (response.statusCode == CMPLRService.requestSuccess) {
      for (var i = 0; i < responseBody['messages'].length; i++) {
        conversationMessages.add(
          Message.fromJson(json: responseBody, outOrIn: false, index: i),
        );
      }
    }
  }
}
