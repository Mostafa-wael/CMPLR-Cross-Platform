import 'dart:convert';

import '../../../../backend_uris.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';

class ModelEmailPasswordLogin {
  Future<bool> checkEmailPasswordCombination(
      String email, String password) async {
    final validEmail = validateEmail(email);
    if (!validEmail || password.isEmpty) return Future.value(false);

    if (!validEmail) return Future.value(false);

    final response = await CMPLRService.post(
      PostURIs.login,
      {
        'Email': email,
        'Password': password,
      },
    );

    final errors = [];
    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    return responseMap.containsKey('error') ? responseMap['error'] : [];
  }
}
