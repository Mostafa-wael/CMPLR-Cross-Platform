import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PersistentStorage {
  static void changeLoggedIn(bool newVal) =>
      GetStorage().write('logged_in', newVal);

  static bool get isLoggedIn => GetStorage().read('logged_in') ?? false;

  static void initStorage() async => await GetStorage.init();

  static void clearStorage() async => await GetStorage().erase();
}
