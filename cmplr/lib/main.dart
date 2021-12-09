import 'flags.dart';
import 'cmplr_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'views/views.dart';
import '../../utilities/sizing/sizing.dart';

Future<void> main() async {
  await GetStorage.init();

  // Clears all persistent data based on a flag
  // USE CAREFULLY
  if (Flags.cleanState) {
    GetStorage().erase();
  }
  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themes = <ThemeData>[CMPLRTheme.trueBlue(), CMPLRTheme.darkTheme()];
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStorage().read('logged_in') ?? false
          ? const MasterPage() /*const MasterPage()*/
          : const SignupOrLoginScreen() /*SignupOrLoginScreen()*/,
      theme: themes[1],
      getPages: getLoginAndSignPages + getHomeScreenPages,
    );
  }

  List<GetPage<dynamic>> get getHomeScreenPages {
    return [
      GetPage(
          name: '/profile', page: () => const Center(child: Text('Profile'))),
      GetPage(name: '/home_tab', page: () => const HomeScreen()),
      GetPage(name: '/write_post', page: () => const WritePost()),
      GetPage(name: '/reblog', page: () => const ReblogView()),
      GetPage(name: '/notes', page: () => Notes()),
      GetPage(
          name: '/home_following_tab', page: () => const HomeFollowingScreen()),
    ];
  }
}

List<GetPage<dynamic>> get getLoginAndSignPages {
  return [
    GetPage(name: '/reblog', page: () => const ReblogView()),
    GetPage(
        name: '/signup_or_login_screen',
        page: () => const SignupOrLoginScreen()),
    GetPage(
        name: '/signup_email_or_google',
        page: () => const SignupEmailOrGoogle()),
    GetPage(name: '/signup_age_screen', page: () => const SignupAge()),
    GetPage(
        name: '/signup_preferences_search_screen',
        page: () => const SignupPreferencesSearch()),
    GetPage(
        name: '/signup_preferences_screen',
        page: () => const SignupPreferences()),
    GetPage(
        name: '/signup_preferences_search_screen',
        page: () => const SignupPreferencesSearch()),
    GetPage(
        name: '/signup_mail_name_screen', page: () => const SignupMailName()),
    GetPage(
        name: '/login_email_or_google', page: () => const LoginEmailOrGoogle()),
    GetPage(name: '/login_email_splash', page: () => const LoginEmailSplash()),
    GetPage(name: '/login_email', page: () => const LoginEmail()),
    GetPage(
        name: '/login_email_continue', page: () => const LoginEmailContinue()),
    GetPage(
        name: '/login_email_password', page: () => const LoginEmailPassword()),
    GetPage(name: '/forgot_password', page: () => const ForgotPassword()),
    GetPage(
        name: '/post_forgot_password', page: () => const PostForgotPassword()),
  ];
}
