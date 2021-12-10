<<<<<<< Updated upstream
import '../../../../flags.dart';
import 'abs_email_password_name_after_signup.dart';
import 'api_email_password_name_after_signup.dart';
import 'mock_email_password_name_after_signup.dart';

class ModelEmailPasswordNameAfterSignup {
  // Whether we're using the API or mock services
  final AbstractEmailPasswordNameAfterSignup interface = Flags.mock
      ? MockEmailPasswordNameAfterSignupModel()
      : APIEmailPasswordNameAfterSignup();

  bool checkEmailPasswordName(String email, String password, String name) {
    return interface.checkEmailPasswordName(email, password, name);
=======
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../backend_uris.dart';
import '../../../../utilities/functions.dart';
import '../../../cmplr_service.dart';

class ModelEmailPasswordNameAfterSignup {
  Future<List> checkEmailPasswordName(
      String email, String password, String name) async {
    // TODO: Check if BlogName really maps to account name
    // TODO: Add onError clause?
    // TODO: Not sure if we need to await the response or not?
    final validEmail = validateEmail(email);

    if (!validEmail) return Future.value(['Invalid email']);

    // Check with the backend
    final response = await CMPLRService.post(
      PostURIs.signup,
      {
        'Email': email,
        'Password': password,
        'BlogName': name,
      },
    );

    // Check response for errors
    return jsonDecode(response.body);
>>>>>>> Stashed changes
  }
}
