import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class User {
  static String get avatarURL => GetStorage().read('avatar');
  static String get blogName => GetStorage().read('blog_name');
  static String get token => GetStorage().read('token');

  static var avatarImage = FadeInImage.assetNetwork(
      placeholder: 'lib/utilities/assets/logo/logo_icon.png', image: avatarURL);

  static void storeUserData(
      String blogName, String avatarURL, String token, Map userMap) async {
    await GetStorage().write('blog_name', blogName);

    // FIXME: Still not in the backend
    await GetStorage().write('avatar', avatarURL);
    await GetStorage().write('token', token);
    await GetStorage().write('user', userMap);
  }

  static void prepareMockData() async {
    const avatarURL =
        'https://64.media.tumblr.com/6cdf4f960de87ce74725e817ce52d909/tumblr_ontl0xdEAZ1tspryno1_250.jpg';

    await GetStorage().write('blog_name', 'mock-name');
    await GetStorage().write('avatar', avatarURL);
    await GetStorage().write(
        'token',
        // ignore: lines_longer_than_80_chars
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYmU4NjdlZGI3ZjA3OWE5Y2E4NjFhY2U1YmViZjBiZDViMDE1ZGQwMmM3MjJhNjk4NmViN2E5NTI4ZDQ5Mzc2NTJjYjA0YTA5OWYwZGJiNDQiLCJpYXQiOjE2NDAyMDg2MzcuNjg5MzcyLCJuYmYiOjE2NDAyMDg2MzcuNjg5Mzc2LCJleHAiOjE2NzE3NDQ2MzcuNjUxMzU3LCJzdWIiOiIyNCIsInNjb3BlcyI6W119.HID1nDI_JtuONMEXWlqB8eR1RWkPopbRehAW-Tn6FuBHOWPEOGMq7kDaVfGt-SPGCPD3xGmeaIieNTUk7p-N-_YfPtS1RvcshCJ8YjZ-BrxX9qbP8XlgsF9tkScGBAr_p4TdRPFk0XEcs8wR-LCPLGd6sDRm17X7Y0ciPkf-20YHwMbWJoY2RhG-GnvbQDGmoENMa47MjCrIXvjmEU9ZDg4xHHVcdPGa1RRS_7BPYabIoCqEJIdfnKG0C1BYcEfhurYxJ452UzuCRxbf_N8aOrToa6bab2bSBkxoHVH79D20b4lxJoU9FD-tfJ_gW7BKYqZhuCRjh4AKyBhlVzv_bbUEuunwtVasxlnL-4J6rPs3-R1LQbTqFeEbNDI93h_v-W6M-08bYrsw1Bx3cUno29Th-rGchbw0ysyb4o0ZNcCUY8UVztCnN9rYfZR8LDJI3nJukhmciaNx84l36uvMaJ1arl-iI7_1XjQBL7V8d03Of0R2QrpWUcakzHeVhV5FHmMqq6gtVi0pYnJdSPM47AT8rKrSE_DcIkNER6bUihLLF8DceIJQMFkf7aGDVf8VT1rxr7tFz7266cHrhtvGO8OWA9gxbksM3swXCwufrQqNJfonX-hbX-bb9vlh99s927eKk0Cz8MSWQ4NBMibEInswiPVBw1nTaACprKTkkuk');

    // TODO: mock this
    await GetStorage().write('user', {});
  }
}
