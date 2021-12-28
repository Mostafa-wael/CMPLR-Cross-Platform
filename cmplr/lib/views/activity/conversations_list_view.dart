import 'package:flutter/material.dart';
import '../../models/pages_model/activity_tab/chat_model.dart';
import 'conversation_messages_view.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({Key? key}) : super(key: key);

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    ModelChatModule.getConversationsList().then((dummy) => {
          setState(() {
            _isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                color: Colors.white,
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
                  itemCount: ModelChatModule.conversationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // ignore: omit_local_variable_types
                    final Message chat =
                        ModelChatModule.conversationsList[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            user: chat.sender,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 20.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: chat.isRead
                              ? const Color(0xFFFFEFEE)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.network(chat.sender.avatar, scale: 3),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      chat.sender.blog_name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        chat.text,
                                        style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
