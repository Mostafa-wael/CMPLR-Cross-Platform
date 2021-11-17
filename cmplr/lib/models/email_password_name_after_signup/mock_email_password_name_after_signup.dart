import 'dart:collection';

import 'abs_email_password_name_after_signup.dart';

/// Mocks the user sign up process.
///
/// Given the user's email and username, it checks if they're both available
/// Should return some error code to indicate:
///    - false (username/email or both already registered)
///    - true if all data is OK
class MockEmailPasswordNameAfterSignupModel
    implements AbstractEmailPasswordNameAfterSignup {
  // ["EMAIL","USERNAME"]
  var registeredEmails = HashSet<String>();
  var registeredNames = HashSet<String>();

  MockEmailPasswordNameAfterSignupModel() {
    registeredEmails.add('tarek@cmplr.org');
    registeredEmails.add('jimbo@cmprl.cum');
    registeredEmails.add('wael@bekes.net');
    registeredEmails.add('gendy@cmplr.eg');

    registeredNames.add('burh');
    registeredNames.add('nerd');
    registeredNames.add('kak');
    registeredNames.add('AAA');
  }

  @override
  bool checkEmailPasswordName(String email, String password, String name) {
    if (email.isEmpty || password.isEmpty || name.isEmpty) return false;

    // Regex borrowed from https://stackoverflow.com/questions/16800540/validate-email-address-in-dart
    final validEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    final existingEmail = registeredEmails.contains(email);
    final existingName = registeredNames.contains(name);

    if (!validEmail || existingEmail || existingName) return false;

    registeredNames.add(name);
    registeredEmails.add(email);
    return true;
  }
}
