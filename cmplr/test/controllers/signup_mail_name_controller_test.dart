import 'package:cmplr/flags.dart';
import 'package:cmplr/models/persistent_storage_api.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../lib/controllers/controllers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() async {
  const emailTaken = 'The email has already been taken';
  const blogNameTaken = 'The blog name has already been taken';

  // Fixes GetStorage() for tests
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  void setUpMockChannels(MethodChannel channel) {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '.';
      }
    });
  }

  setUpAll(() async {
    setUpMockChannels(channel);
  });

  setUp(() async {
    await GetStorage.init();
    await GetStorage().erase();

    Get.testMode = true;
  });

  testWidgets('email password name after signup controller ...',
      (tester) async {
    PersistentStorage.changeLoggedIn(false);

    // passwordHidden = true, validInfo = true
    final masterPageCont = MasterPageController();
    Get.put(masterPageCont, permanent: true);
    final controller = EmailPasswordNameAfterSignupController();

    // passwordHidden = false
    controller.togglePasswordHide();
    expect(controller.passwordHidden, false);

    // passwordHidden = true
    controller.togglePasswordHide();
    expect(controller.passwordHidden, true);

    controller.emailController.text = controller.passwordController.text =
        controller.nameController.text = '';
    // Calling validateInfo with *ANY* of them as empty strings
    // should return false
    await controller.validateInfo();
    expect(controller.validInfo, false);

    controller.emailController.text = 'tester@cmplasdasdrTEST.org';
    controller.fieldChanged('');
    expect(controller.validInfo, false);

    controller.passwordController.text = 'aStrongPassword!@#!2';
    controller.fieldChanged('');
    expect(controller.validInfo, false);

    // Since all 3 are different from the mock data, it will return true
    controller.nameController.text = 'pleaseDontAsdasdasReturn';
    controller.fieldChanged('');
    GetStorage().write('age', 19);
    await controller.validateInfo();
    expect(controller.validInfo, true);

    // Email already exists
    controller.emailController.text = 'tarek@cmplr.org';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.errors, [emailTaken, blogNameTaken]);
    expect(controller.validInfo, false);

    // Name already exists
    controller.emailController.text = 'tester@cmplr.org';
    controller.nameController.text = 'burh';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.errors, [blogNameTaken]);
    expect(controller.validInfo, false);
  });
}
