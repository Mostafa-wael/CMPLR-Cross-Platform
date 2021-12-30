import '../models/persistent_storage_api.dart';

import '../controllers/activity/activity_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class User {
  static String get avatarURL => GetStorage().read('user')['avatar'];
  static String get blogName => GetStorage().read('blog_name');
  static String get token => GetStorage().read('token');
  static Map get userMap => GetStorage().read('user');

  static var avatarImage = FadeInImage.assetNetwork(
      placeholder: 'lib/utilities/assets/logo/logo_icon.png', image: avatarURL);

  static void storeUserData(String blogName, String token, Map userMap) async {
    await GetStorage().write('blog_name', blogName);
    await GetStorage().write('token', token);
    await GetStorage().write('user', userMap);
  }

  static void prepareMockData() async {
    await GetStorage().write('blog_name', 'mock-name');
    await GetStorage().write(
        'token',
        // ignore: lines_longer_than_80_chars
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYmU4NjdlZGI3ZjA3OWE5Y2E4NjFhY2U1YmViZjBiZDViMDE1ZGQwMmM3MjJhNjk4NmViN2E5NTI4ZDQ5Mzc2NTJjYjA0YTA5OWYwZGJiNDQiLCJpYXQiOjE2NDAyMDg2MzcuNjg5MzcyLCJuYmYiOjE2NDAyMDg2MzcuNjg5Mzc2LCJleHAiOjE2NzE3NDQ2MzcuNjUxMzU3LCJzdWIiOiIyNCIsInNjb3BlcyI6W119.HID1nDI_JtuONMEXWlqB8eR1RWkPopbRehAW-Tn6FuBHOWPEOGMq7kDaVfGt-SPGCPD3xGmeaIieNTUk7p-N-_YfPtS1RvcshCJ8YjZ-BrxX9qbP8XlgsF9tkScGBAr_p4TdRPFk0XEcs8wR-LCPLGd6sDRm17X7Y0ciPkf-20YHwMbWJoY2RhG-GnvbQDGmoENMa47MjCrIXvjmEU9ZDg4xHHVcdPGa1RRS_7BPYabIoCqEJIdfnKG0C1BYcEfhurYxJ452UzuCRxbf_N8aOrToa6bab2bSBkxoHVH79D20b4lxJoU9FD-tfJ_gW7BKYqZhuCRjh4AKyBhlVzv_bbUEuunwtVasxlnL-4J6rPs3-R1LQbTqFeEbNDI93h_v-W6M-08bYrsw1Bx3cUno29Th-rGchbw0ysyb4o0ZNcCUY8UVztCnN9rYfZR8LDJI3nJukhmciaNx84l36uvMaJ1arl-iI7_1XjQBL7V8d03Of0R2QrpWUcakzHeVhV5FHmMqq6gtVi0pYnJdSPM47AT8rKrSE_DcIkNER6bUihLLF8DceIJQMFkf7aGDVf8VT1rxr7tFz7266cHrhtvGO8OWA9gxbksM3swXCwufrQqNJfonX-hbX-bb9vlh99s927eKk0Cz8MSWQ4NBMibEInswiPVBw1nTaACprKTkkuk');

    await GetStorage().write(
      'user',
      {
        'id': 11,
        'email': 'tarek@cmplr.com',
        'email_verified_at': null,
        'age': 21,
        'default_post_format': null,
        'login_options': false,
        'TFA': false,
        'filtered_tags': null,
        'endless_scrolling': true,
        'show_badge': true,
        'text_editor': 'rich',
        'msg_sound': true,
        'best_stuff_first': true,
        'include_followed_tags': true,
        'conversational_notification': true,
        'filtered_content': null,
        'theme': 'trueBlue',
        'primary_blog_id': 11,
        'blog_name': 'yousif',
        'avatar':
            r'https:\/\/assets.tumblr.com\/images\/default_avatar\/cone_closed_128.png',
        'avatar_shape': 'circle'
      },
    );
  }

  static void logOut() {
    PersistentStorage.changeLoggedIn(false);
    GetStorage().remove('blog_name');
    GetStorage().remove('tokens');
    GetStorage().remove('user');

    final activityActivityController = Get.find<ActivityActivityController>();
    activityActivityController.fetchTimer?.cancel();
  }
}
