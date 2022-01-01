import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../lib/models/persistent_storage_api.dart';
import '../../lib/controllers/controllers.dart';
import '../../lib/flags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  const emptyPassword = 'Password is empty';
  const invalidEmail = 'Invalid Email';

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
  });

  testWidgets('login controller', (tester) async {
    Get.testMode = true;
    Flags.mock = true;
    PersistentStorage.changeLoggedIn(false);

    final controller = LoginController();

    // email field empty, password field empty
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, false);
    expect(controller.activateSubmitButton, false);
    expect(controller.activateLoginButton, false);
    // (Tarek) TODO: Make sure this is tested somewhere?
    expect(controller.validLoginEmail, false);
    expect(await controller.tryLogin(), [emptyPassword, invalidEmail]);

    // email is 'aaaa@aaaa.org' (invalid email, not registered),
    // password field empty
    controller.emailController.text = 'aaaa@aaaa.org';
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, false);
    expect(controller.validLoginEmail, true);
    expect(await controller.tryLogin(), [emptyPassword]);

    // email is 'tarek@cmplr.org' (valid email, registered)
    // password field empty
    controller.emailController.text = 'tarek@cmplr.org';
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, false);
    expect(controller.validLoginEmail, true);
    expect(await controller.tryLogin(), [emptyPassword]);

    // email field empty, password is '1234'
    controller.passwordController.text = '1234';
    controller.emailController.text = '';
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, false);
    expect(controller.activateSubmitButton, false);
    expect(controller.activateLoginButton, false);
    expect(controller.validLoginEmail, false);
    expect(await controller.tryLogin(), [invalidEmail]);

    // email is 'tarek@cmplr.org', password is '1234'
    // (valid email, invalid password)
    controller.passwordController.text = '1234';
    controller.emailController.text = 'tarek@cmplr.org';
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, true);
    expect(controller.validLoginEmail, true);
    expect(await controller.tryLogin(), ['UnAuthorized']);

    // email is 'tarek@cmplr.org', password is'12345678'
    // (valid email & password)
    controller.passwordController.text = '12345678';
    controller.emailController.text = 'tarek@cmplr.org';
    await controller.emailFieldChanged();
    await controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, true);
    expect(controller.validLoginEmail, true);
    expect(await controller.tryLogin(), []);
  });
}
