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

  static var userData = {
    'id': 15,
    'email': '"yousif.lasheen60@gmail.com',
    'email_verified_at': '2021-12-10T22:23:06.000000Z',
    'age': 21,
    'following_count': 0,
    'likes_count': 0,
    'default_post_format': null,
    'login_options': null,
    'email_activity_check': false,
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
    'google_id': null,
    'theme': 'trueBlue',
    'primary_blog_id': 15,
    'created_at': '2021-12-10T22:12:53.000000Z',
    'updated_at': '2021-12-10T22:23:06.000000Z'
  };
  static var userToken =
      '''eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzR
    iZGY0NTQzMWNmNzg5YWY5ZjdkNTFlMzU1OGY0MTNkZWUxZmQ2YWRhMDJmZjNmOWEyZTM3MzgzZW
    RmZTYzODE4Zjk1Y2U4NjRjOGEyYjciLCJpYXQiOjE2MzkyMjc1ODcuMDEzNDY5LCJuYmYiOjE2M
    zkyMjc1ODcuMDEzNDkzLCJleHAiOjE2NzA3NjM1ODYuOTEzNzI4LCJzdWIiOiIxNSIsInNjb3Blc
    yI6W119.my5ba7yamcJSoNa8BDEP3CY5dWskjZbGCsC9xkalgEWrVxKDRoj_mTBvAFTncEylY-7l
    o9XoTkAC0Zn86wTgn5ubx5X2-I8s0cBXrC86cRjdYygMQOw_yYmNsuTXlXb5sQwn9Xg6ilfVCvp4
    s_OCjsCHqfSZHHg-6pbe2p0BzdGsMmup-fv3T_prcGAKgRca6AB_wa27utGkFYuOAAqn7YXH7
    gKZU2CGObxfLRxn1fLO95ETLTN_sYz37V1MaDUQZcD9I5WHo6qF6D-ccXjOlcagfaH---bi
    yEKaQJkpgIUqhAwrFIvScOeAPvnmcuCFTwtURIC98PhhYkgD6BFwO5VOY4mYEdVWFAkUte
    kbvUaNbrRukW_QYY55DzxHFsfky5txe1T5XfdFVGmlqGVzBBT4EbExlsA3cU1ALrAuqmdMl
    QQb_101q5IyzPwQmhpA3Ta92PPICbWN1U8o4C9xBhGIVrzkhJM41iCwX25WVju6-TGkQnJ7
    cs6KVNK5CJ2oFA1gjtJycPmJcX1KxngqzTAFTyeCQFEy_QVlJ_aveR8hCUgfdz9KJZTLI6
    u5zupTZuP_axa66H4xPujO8tn2ifgVF7q7qJeFbxw1nL4zrSx49B6VySjUMaR2FAgShl35
    iy6Jw4ICfHX1yJOU5cwAOb358iz-qnnD-oLRqRNrcHI''';
}
