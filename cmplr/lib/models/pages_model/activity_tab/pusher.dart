import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../cmplr_service.dart';
import '../../../utilities/user.dart';
import 'package:pusher_client/pusher_client.dart';

import 'chat_model.dart';

Future<void> initPusher() async {
  pusher = PusherClient(
    'fda8bb30758c845460d8',
    PusherOptions(
      auth: PusherAuth(
        CMPLRService.apiIp,
        headers: CMPLRService.postHeader,
      ),
      cluster: 'eu',
    ),
  );
}

late PusherClient pusher;
late Channel channel;
