import 'package:cmplr/flags.dart';
import 'package:cmplr/models/persistent_storage_api.dart';

import '../../lib/controllers/controllers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() {
    PersistentStorage.initStorage();
    Get.testMode = true;
    Flags.mock = true;
    PersistentStorage.changeLoggedIn(false);
  });

  testWidgets('email password name after signup controller ...',
      (tester) async {
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

    controller.emailController.text = 'tester@cmplr.org';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, false);

    controller.passwordController.text = 'aReallyStrongPassword!@#!';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, false);

    controller.passwordController.text = 'aReallyStrongPassword!@#!';
    await controller.validateInfo();
    expect(controller.validInfo, false);

    // Since all 3 are different from the mock data, it will return true
    controller.nameController.text = 'too much for one project';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, true);

    // Email already exists
    controller.emailController.text = 'tarek@cmplr.org';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, false);

    // Name already exists
    controller.emailController.text = 'tester@cmplr.org';
    controller.nameController.text = 'burh';
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, false);
  });
}
