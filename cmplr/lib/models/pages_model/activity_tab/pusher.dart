import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../utilities/user.dart';
import 'package:pusher_client/pusher_client.dart';

Future<void> initPusher() async {
  pusher = PusherClient(
    'fda8bb30758c845460d8',
    PusherOptions(
      auth: PusherAuth(
        'https://www.beta.cmplr.tech/api',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':
              // ignore: lines_longer_than_80_chars
              'Bearer ${GetStorage().read('token')}'
        },
      ),
      cluster: 'eu',
    ),
  );
}

// void bindEvent(String channelName, String eventName) async {
//   await initPusher();
//   pusher.connect();
//   channel = pusher.subscribe(channelName);
//   await channel.bind(eventName, (final last) {
//     final data = last!.data.toString();
//     final encodedRes = jsonDecode(data);
//     if (encodedRes['from_blog_id'].toString() != User.userMap['id']) {
//       messages.insert(
//           0,
//           Message(encodedRes['from_blog_username'].toString(), '',
//               encodedRes['text']));
//       setState(() {});
//     }
//   });
// }

late PusherClient pusher;
late Channel channel;
