import 'dart:convert';

import '../../../../backend_uris.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';

class ModelEmailPasswordLogin {
  Future<List> checkEmailPasswordCombination(
      String email, String password) async {
    final validEmail = validateEmail(email);

    final errors = [];
    if (password.isEmpty) errors.add('Password is empty');

    if (!validEmail) errors.add('Invalid Email');

    if (!errors.isEmpty) return errors;

    final response = await CMPLRService.post(
      PostURIs.login,
      {
        'email': email,
        'password': password,
      },
    );

    // FIXME: Check if the response for a failed login is a nested map
    // or a list
    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    return responseMap.containsKey('error') ? responseMap['error'] : [];
  }
}
