import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  final s = GetStorage();
  s.write('logged_in', false);

  testWidgets('email password name after signup controller ...',
      (tester) async {
    Flags.mock = true;

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

    // emailController.text = passwordController.text = nameController.text = ''
    // Calling validateInfo with *ANY* of them as empty strings
    // should return false
    controller.validateInfo();
    expect(controller.validInfo, false);

    controller.emailController.text = 'tester@cmplr.org';
<<<<<<< Updated upstream
    controller.validateInfo();
    expect(controller.validInfo, false);

    controller.passwordController.text = 'aReallyStrongPassword!@#!';
    controller.validateInfo();
=======
    controller.fieldChanged('');
    await controller.validateInfo();
    expect(controller.validInfo, false);

    controller.passwordController.text = 'aReallyStrongPassword!@#!';
    controller.fieldChanged('');
    await controller.validateInfo();
>>>>>>> Stashed changes
    expect(controller.validInfo, false);

    // Since all 3 are different from the mock data, it will return true
    controller.nameController.text = 'too much for one project';
<<<<<<< Updated upstream
    controller.validateInfo();
=======
    controller.fieldChanged('');
    await controller.validateInfo();
>>>>>>> Stashed changes
    expect(controller.validInfo, true);

    // Email already exists
    controller.emailController.text = 'tarek@cmplr.org';
<<<<<<< Updated upstream
    controller.validateInfo();
=======
    controller.fieldChanged('');
    await controller.validateInfo();
>>>>>>> Stashed changes
    expect(controller.validInfo, false);

    // Name already exists
    controller.emailController.text = 'tester@cmplr.org';
    controller.nameController.text = 'burh';
<<<<<<< Updated upstream
    controller.validateInfo();
=======
    controller.fieldChanged('');
    await controller.validateInfo();
>>>>>>> Stashed changes
    expect(controller.validInfo, false);
  });
}
