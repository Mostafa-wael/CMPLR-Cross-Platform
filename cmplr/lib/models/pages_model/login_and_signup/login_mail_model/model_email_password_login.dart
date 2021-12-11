import 'dart:convert';

import '../../../../backend_uris.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';

class ModelEmailPasswordLogin {
  Future<List> checkEmailPasswordCombination(
      String email, String password) async {
    final validEmail = validateEmail(email);
    if (!validEmail || password.isEmpty)
      return Future.value(['Empty email or password']);

    if (!validEmail) return Future.value(['Invalid email']);

    final response = await CMPLRService.post(
      PostURIs.login,
      {
        'email': email,
        'password': password,
      },
    );

    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    return responseMap.containsKey('error') ? responseMap['error'] : [];
  }
}
