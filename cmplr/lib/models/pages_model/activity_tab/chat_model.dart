// ignore: lines_longer_than_80_chars
// ignore_for_file: non_constant_identifier_names, prefer_equal_for_default_values, prefer_single_quotes, unnecessary_string_escapes
import 'dart:math';

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
              blog_id: int.parse(json['blog_data']['blog_id']),
              blog_url: json['blog_data']['blog_url'],
              blog_name: json['blog_data']['blog_name'],
              avatar: json['blog_data']['avatar'],
            ),
            text: json['content'],
            isRead: json['is_read'],
          )
        : Message(
            sender: ChatUser(
              blog_id: int.parse(json['messages'][0]['from_blog_id']),
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
  static final messages = <Message>[];
  static final chats = <Message>[];

  ModelChatModule() {
    print('Crateed ModelChatModule');
  }
  static Future<void> getConversationsList() async {
    // the chat menu from outside
    final response = await CMPLRService.get(GetURIs.conversationsList, {});
    final responseBody = jsonDecode(response.body);
    print('get messages');
    for (var i = 0; i < responseBody['responseBody'].length; i++) {
      messages.add(
        Message.fromJson(json: responseBody['responseBody'][i], outOrIn: true),
      );
    }
  }

  static Future<void> getConversationMessages() async {
    // inside the chat itself
    final response = await CMPLRService.get(GetURIs.conversationMessages, {});
    final responseBody = jsonDecode(response.body);
    print('get chats');
    for (var i = 0; i < responseBody['responseBody']['messages'].length; i++) {
      chats.add(
        Message.fromJson(
            json: responseBody['responseBody'], outOrIn: false, index: i),
      );
    }
  }
}
