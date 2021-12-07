import 'dart:collection';
import 'abs_email_password_login.dart';

/// Mocks the user sign in process.
///
/// Given the user's email and password, it checks if they're both available
/// Should return some error code to indicate:
///    - false (this email/password combination or google account is wrong)
///    - true if all data is OK
class MockEmailPasswordLoginModel implements AbstractEmailPasswordLogin {
  // ["EMAIL","USERNAME"]
  var enteredEmailsPasswords = HashMap<String, String>();
  // TODO: Test using my info
  // email:cmplr.mock@gmail.com
  // password: cmplr_mock_flutter
  var googleAccount = ['cmplr.mock@gmail.com', ''];

  MockEmailPasswordLoginModel() {
    enteredEmailsPasswords['tarek@cmplr.org'] = '12345678';
    enteredEmailsPasswords['gendy@cmplr.eg'] = 'hey12345';
    enteredEmailsPasswords['wael@bekes.net'] = 'sad43210';
    enteredEmailsPasswords['jimbo@cmprl.com'] = 'Anime6420';
  }

  @override
  bool checkEmailPasswordCombination(String email, String password) {
    if (email.isEmpty || password.isEmpty) return false;

    final validEmail = validateEmail(email);
    final matchingEmailPasswordCombination =
        enteredEmailsPasswords[email] == password;

    // Regex borrowed from https://stackoverflow.com/questions/16800540/validate-email-address-in-dart
    if (!validEmail || !matchingEmailPasswordCombination) return false;

    return true;
  }

  // (Tarek) TODO: Something similar is used for verifying signup
  // Need to refactor this.
  @override
  bool validateEmail(String email) {
    print(enteredEmailsPasswords[email]);
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) &&
        enteredEmailsPasswords[email] != null;
  }

  @override
  bool validateGoogleAccount(account) {
    return account == googleAccount;
  }
}
