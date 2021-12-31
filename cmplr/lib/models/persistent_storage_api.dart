import 'package:get_storage/get_storage.dart';

/// To deal with the Persistent Storage
class PersistentStorage {
  static void changeLoggedIn(bool newVal) =>
      GetStorage().write('logged_in', newVal);

  static bool? get isLoggedIn => GetStorage().read('logged_in');

  static Future<bool> initStorage({String container = 'GetStorage'}) async =>
      GetStorage.init();

  static Future<void> clearStorage() async => GetStorage().erase();
}
