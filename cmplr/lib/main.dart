import 'controllers/controllers.dart';
import 'models/models.dart';

import 'models/persistent_storage_api.dart';

import 'flags.dart';
import 'cmplr_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/views.dart';
import './routes.dart';

// import 'package:flutter_driver/driver_extension.dart';

Future<void> main() async {
  await PersistentStorage.initStorage();

  // Clears all persistent data based on a flag
  // USE CAREFULLY
  if (Flags.cleanState) {
    await PersistentStorage.clearStorage();
  }

  Get.put(ReblogController(const ReblogModel()));
  Get.put(WritePostController(const WritePostModel()));

  // enableFlutterDriverExtension();
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
      home: PersistentStorage.isLoggedIn ?? false
          ? const MasterPage() /*const MasterPage()*/
          : const SignupOrLoginScreen() /*SignupOrLoginScreen()*/,
      theme: themes[1],
      getPages: getLoginAndSignPages + getHomeScreenPages,
    );
  }

  List<GetPage<dynamic>> get getHomeScreenPages {
    return [
      GetPage(
          name: Routes.profile,
          page: () => const Center(child: Text('Profile'))),
      GetPage(name: Routes.homeTab, page: () => const HomeScreen()),
      GetPage(name: Routes.writePost, page: () => const WritePost()),
      GetPage(name: Routes.reblog, page: () => const ReblogView()),
      GetPage(name: Routes.notes, page: () => Notes()),
      GetPage(
          name: Routes.homeFollowingTab,
          page: () => const HomeFollowingScreen()),
    ];
  }
}

List<GetPage<dynamic>> get getLoginAndSignPages {
  return [
    GetPage(name: Routes.reblog, page: () => const ReblogView()),
    GetPage(
        name: Routes.signupOrLoginScreen,
        page: () => const SignupOrLoginScreen()),
    GetPage(
        name: Routes.signupEmailOrGoogle,
        page: () => const SignupEmailOrGoogle()),
    GetPage(name: Routes.signupAgeScreen, page: () => const SignupAge()),
    GetPage(
        name: Routes.signupPreferencesSearchScreen,
        page: () => const SignupPreferencesSearch()),
    GetPage(
        name: Routes.signupPreferencesScreen,
        page: () => const SignupPreferences()),
    GetPage(
        name: Routes.signupMailNameScreen, page: () => const SignupMailName()),
    GetPage(
        name: Routes.loginEmailOrGoogle,
        page: () => const LoginEmailOrGoogle()),
    GetPage(
        name: Routes.loginEmailSplash, page: () => const LoginEmailSplash()),
    GetPage(
      name: Routes.loginEmail,
      page: () => const LoginEmail(),
    ),
    GetPage(
        name: Routes.loginEmailPassword,
        page: () => const LoginEmailPassword()),
    GetPage(name: Routes.forgotPassword, page: () => const ForgotPassword()),
    GetPage(
        name: Routes.postForgotPassword,
        page: () => const PostForgotPassword()),
    GetPage(
        name: Routes.loginEmailContinue,
        page: () => const LoginEmailContinue()),
  ];
}
