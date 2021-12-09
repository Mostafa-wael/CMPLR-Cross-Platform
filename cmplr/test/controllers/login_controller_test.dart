import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login controller', (tester) async {
    Flags.mock = true;

    final controller = LoginController();

    // email field empty, password field empty
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, false);
    expect(controller.activateSubmitButton, false);
    expect(controller.activateLoginButton, false);
    expect(controller.validCombination, false);
    expect(controller.validLoginEmail, false);

    // email is 'aaaa@aaaa.org' (invalid email, not registered),
    // password field empty
    controller.emailController.text = 'aaaa@aaaa.org';
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, false);
    expect(controller.validCombination, false);
    expect(controller.validLoginEmail, false);

    // email is 'tarek@cmplr.org' (valid email, registered)
    // password field empty
    controller.emailController.text = 'tarek@cmplr.org';
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, false);
    expect(controller.validCombination, false);
    expect(controller.validLoginEmail, true);

    // email field empty, password is '1234'
    controller.passwordController.text = '1234';
    controller.emailController.text = '';
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, false);
    expect(controller.activateSubmitButton, false);
    expect(controller.activateLoginButton, false);
    expect(controller.validCombination, false);
    expect(controller.validLoginEmail, false);

    // email is 'tarek@cmplr.org', password is '1234'
    // (valid email, invalid password)
    controller.passwordController.text = '1234';
    controller.emailController.text = 'tarek@cmplr.org';
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, true);
    expect(controller.validCombination, false);
    expect(controller.validLoginEmail, true);

    // email is 'tarek@cmplr.org', password is'12345678'
    // (valid email & password)
    controller.passwordController.text = '12345678';
    controller.emailController.text = 'tarek@cmplr.org';
    controller.emailFieldChanged();
    controller.passwordFieldChanged();
    expect(controller.showClearIcon, true);
    expect(controller.activateSubmitButton, true);
    expect(controller.activateLoginButton, true);
    expect(controller.validCombination, true);
    expect(controller.validLoginEmail, true);
  });
}
