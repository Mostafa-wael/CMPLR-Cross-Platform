import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/pages_model/activity_tab/chat_model.dart';
import 'conversation_messages_view.dart';

final messagesState = GlobalKey<ConversationsListState>();

class ConversationsList extends StatefulWidget {
  const ConversationsList({Key? key}) : super(key: key);

  @override
  State<ConversationsList> createState() => ConversationsListState();
}

class ConversationsListState extends State<ConversationsList> {
  bool _isLoading = true;

  void fetchData() {
    ModelChatModule.getConversationsList().then((dummy) => {
          setState(() {
            _isLoading = false;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
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
                      key: ValueKey('chat_${index}'),
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
                              ? Colors.blue //
                              : Get.theme.scaffoldBackgroundColor,
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
                                SizedBox(
                                    width: Sizing.blockSizeVertical * 6,
                                    height: Sizing.blockSizeVertical * 6,
                                    child: Image.network(
                                      chat.sender.avatar,
                                      scale: 3,
                                      fit: BoxFit.fill,
                                    )),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      chat.sender.blog_name,
                                      style: TextStyle(
                                        color: Get
                                            .theme.textTheme.bodyText1?.color,
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
                                        style: TextStyle(
                                          color: Get
                                              .theme.textTheme.bodyText1?.color,
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
