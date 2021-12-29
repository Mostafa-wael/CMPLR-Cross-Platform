import 'dart:io';
import 'dart:ui';

import 'utilities/user.dart';

import 'controllers/controllers.dart';
import 'models/models.dart';

import 'models/persistent_storage_api.dart';

import 'flags.dart';
import 'cmplr_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_driver/driver_extension.dart';

// Activates swipe controls for web
// Since flutter web doesn't allow shift+scroll for horizontal scrolling
import 'views/views.dart';
import './routes.dart';

// import 'package:flutter_driver/driver_extension.dart';

class MouseAndTourchScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  // enableFlutterDriverExtension();

  HttpOverrides.global = MyHttpOverrides();

  await PersistentStorage.initStorage();

  // Clears all persistent data based on a flag
  // USE CAREFULLY
  if (Flags.cleanState) {
    await PersistentStorage.clearStorage();
  }

  Get.put(ReblogController(const ReblogModel()));
  Get.put(WritePostController(const WritePostModel()));

  // Prepares any GetStorage fields we are supposed to have when we're logged in
  if (Flags.mock) User.prepareMockData();

  runApp(const CMPLR());
}

class CMPLR extends StatelessWidget {
  const CMPLR({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themes = <ThemeData>[CMPLRTheme.trueBlue(), CMPLRTheme.darkTheme()];
    return GetMaterialApp(
      scrollBehavior: MouseAndTourchScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      home: PersistentStorage.isLoggedIn ?? false
          ? const MasterPage() /*const MasterPage()*/
          : const SignupOrLoginScreen() /*SignupOrLoginScreen()*/,
      theme: Get.isDarkMode ? themes[1] : themes[0],
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
      GetPage(name: Routes.homeFollowingTab, page: () => const HomeFollowing()),
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
