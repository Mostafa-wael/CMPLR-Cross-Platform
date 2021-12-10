import 'dart:convert';

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
  }
}
