import '../../../cmplr_service.dart';

class ModelEmailPasswordNameAfterSignup {
  // Whether we're using the API or mock services
  // final AbstractEmailPasswordNameAfterSignup interface = Flags.mock
  //     ? MockEmailPasswordNameAfterSignupModel()
  //     : APIEmailPasswordNameAfterSignup();

  Future<bool> checkEmailPasswordName(
      String email, String password, String name) async {
    // TODO: Check if BlogName really maps to account name
    // TODO: Add onError clause?
    // TODO: Not sure if we need to await the response or not?
    final validEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    // Check locally if the email is valid before checking with the backend
    // Return prematurally if not
    if (!validEmail || password.isEmpty || email.isEmpty || name.isEmpty)
      return Future.value(false);

    // Check with the backend
    var validEmailAndName = Future.value(false);
    await CMPLRService.post('/signup_mail_name_screen', {
      'Email': email,
      'Password': password,
      'BlogName': name
    }).then((response) => validEmailAndName =
        Future.value(response.statusCode == CMPLRService.requestSuccess));

    return validEmailAndName;
  }
}
