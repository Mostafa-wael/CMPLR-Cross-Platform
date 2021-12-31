import 'package:flutter/material.dart';

import 'conversations_list_view.dart';

/// Sub-view for the messages tab.
class ActivityMessages extends StatelessWidget {
  const ActivityMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ConversationsList();
  }
}
