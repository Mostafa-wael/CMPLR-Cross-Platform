// ignore_for_file: omit_local_variable_types
import 'dart:convert';
import 'dart:math';
import '../../models/pages_model/activity_tab/pusher.dart';

import '../../utilities/user.dart';
import 'package:flutter/material.dart';
import '../../models/pages_model/activity_tab/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  // ignore: use_key_in_widget_constructors
  const ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void bindEvent(String channelName) async {
    await initPusher();
    pusher.connect();
    channel = pusher.subscribe(channelName);
    // ignore: use_raw_strings, prefer_single_quotes
    await channel.bind("App\\Events\\MessageSent", (final last) {
      final data = last!.data.toString();
      final encodedRes = jsonDecode(data);
      print('Pusher is Called');

      ModelChatModule.conversationMessages.insert(
          0,
          Message(
            sender: ChatUser(
              blog_id: int.parse(encodedRes['sender_id']),
              blog_url: '',
              blog_name: '',
              avatar: '',
            ),
            text: encodedRes['message']['content'],
            isRead: encodedRes['message']['is_read'],
          ));
      setState(() {});
    });
  }

  bool _isLoading = true;
  final _textController = TextEditingController();
  @override
  void initState() {
    final first = min(int.parse(User.userMap['primary_blog_id'].toString()),
        widget.user.blog_id);
    final second = max(int.parse(User.userMap['primary_blog_id'].toString()),
        widget.user.blog_id);
    final channel = 'chat-' + first.toString() + '-' + second.toString();
    print(channel);
    bindEvent(channel);
    super.initState();
    ModelChatModule.getConversationMessages(widget.user.blog_id)
        .then((dummy) => {
              setState(() {
                _isLoading = false;
              })
            });
  }

  Widget _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFCCCCFCC) : const Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.cyan,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: Colors.white,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              key: const ValueKey('chat_textField'),
              controller: _textController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            key: const ValueKey('chatSend'),
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.white,
            onPressed: () {
              print(_textController.text);
              ModelChatModule.sendMessage(
                  widget.user.blog_id, _textController.text);
              _textController.text = '';
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.user.blog_name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            _isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.only(top: 15.0),
                          itemCount:
                              ModelChatModule.conversationMessages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Message message =
                                ModelChatModule.conversationMessages[index];
                            final bool isMe = message.sender.blog_id ==
                                User.userMap['primary_blog_id'];
                            return _buildMessage(message, isMe);
                          },
                        ),
                      ),
                    ),
                  ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
