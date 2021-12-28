import 'dart:convert';

import '../../../utilities/user.dart';
import '../../../backend_uris.dart';
import '../../cmplr_service.dart';

class ActivityActivityModel {
  static dynamic getActivityNotifications(List<String> filterTypes) async {
    final response = await CMPLRService.get(
      GetURIs.activityNotifications,
      {'blog-identifier': User.userMap['id'].toString(), 'type': filterTypes},
    );
    if (response.statusCode == CMPLRService.requestSuccess)

      // Should return a list of notifications
      return jsonDecode(response.body)['response'];
  }
}
