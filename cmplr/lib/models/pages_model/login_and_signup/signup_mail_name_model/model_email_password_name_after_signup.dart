import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../../../../flags.dart';
import '../../../../utilities/user.dart';
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
        'email': email,
        'password': password,
        'blog_name': name,
        'age': GetStorage().read('age') ?? 12,
      },
    );
    var errors = [];

    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    // Check response for errors
    if (response.statusCode != CMPLRService.insertSuccess) {
      // Error should be a map with at most? 3 keys:
      // blog_name, email, and password
      // Each should point to an array of errors, we concatenate them here.
      if (responseMap.containsKey('error')) {
        final errorMap = responseMap['error'];
        for (final key in errorMap.keys) {
          errors += errorMap[key];
        }
      }

      // FIXME: Check for this later on
      if (errors.isEmpty) errors.add('Internal server error');
      return errors;
    } else {
      if (!Flags.mock)
        User.storeUserData(
          responseMap['blog_name'],
          responseMap['token'],
          responseMap['user'],
        );
      return [];
    }
  }
}
