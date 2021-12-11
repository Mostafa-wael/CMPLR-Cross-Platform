import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../../backend_uris.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';

class ModelEmailPasswordLogin {
  Future<List> checkEmailPasswordCombination(
      String email, String password) async {
    final validEmail = validateEmail(email);

    var errors = [];
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

    // Error should be a map with at most? 3 keys:
    // blog_name, email, and password
    // Each should point to an array of errors, we concatenate them here.
    if (responseMap.containsKey('error')) {
      final errorMap = responseMap['error'];
      for (final key in errorMap.keys) {
        errors += errorMap[key];
      }
    }

    // TODO: Refactor this
    if (responseMap.containsKey('token')) {
      GetStorage().write('token', responseMap['token']);
      GetStorage().write('user', responseMap['user']);
    }

    // Check response for errors
    return errors;
  }
}
