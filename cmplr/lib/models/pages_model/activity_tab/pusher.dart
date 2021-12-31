import '../../cmplr_service.dart';
import 'package:pusher_client/pusher_client.dart';

/// the initialize pusher function called from the controller
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
