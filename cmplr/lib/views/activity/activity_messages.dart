import 'package:flutter/material.dart';

import 'chat/recent_chats.dart';

class ActivityMessages extends StatelessWidget {
  const ActivityMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RecentChats();
  }
}
