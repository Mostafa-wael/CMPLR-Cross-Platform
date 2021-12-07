import 'dart:async';
import 'dart:convert';

import '../flags.dart';
import 'package:http/http.dart' as http;

/// Our interface to the backend OR our mock data
class CMPLRService {
  /// Maps a route to the mock data it's supposed to receive
  static final Map<String, dynamic> _mockData = {
    // Extra signup whenever the user signups with their email
    // and they want to open their activity or profile screen.
    // each set is used to check whether a given email or username
    // is inside it or not.
    '/signup_mail_name_screen': {
      // set of registered emails
      'emails': {
        'tarek@cmplr.org',
        'jimbo@cmprl.cum',
        'wael@bekes.net',
        'gendy@cmplr.eg',
      },
      // set of used usernames
      'names': {'burh', 'nerd', 'kak', 'AAA'}
    },
  };

  static const requestSuccess = 200;
  static const invalidData = 422;

  static Future<http.Response> post(route, params) async {
    // Switch case since we might need to send requests with different
    // content types
    switch (route) {
      case '/signup_mail_name_screen':
        return signupMailNameVerification(route, params);

      default:
        throw Exception('Invalid request route');
    }
  }

  // TODO: Rename this screen to "extra signup"
  static Future<http.Response> signupMailNameVerification(
      String route, Map params) async {
    if (Flags.mock) {
      final Set emails = _mockData[route]['emails'];
      final Set names = _mockData[route]['names'];

      final registeredEmail = emails.contains(params['Email']);
      final registeredName = names.contains(params['BlogName']);

      final bothFree = !registeredName && !registeredEmail;
      if (bothFree) {
        emails.add(params['Email']);
        names.add(params['BlogName']);
      }

      final responseCode = bothFree ? requestSuccess : invalidData;
      return http.Response('', responseCode);
    } else {
      // TODO: Check if we work with UTF-8 or 16
      // TODO: Check if the URI is correct
      return http.post(
        Uri(path: route),
        headers: {'Content-Type': 'text/plain; charset=UTF-8'},
        body: jsonEncode(params),
      );
    }
  }
}
