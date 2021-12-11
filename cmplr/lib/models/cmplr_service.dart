import 'dart:async';
import 'dart:convert';

import 'package:get/get_connect/http/src/request/request.dart';

import '../backend_uris.dart';

import '../flags.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';

/// Our interface to the backend OR our mock data
class CMPLRService {
  static final Map<String, Set> users = {
    'emails': {
      'tarek@cmplr.org',
      'jimbo@cmprl.cum',
      'wael@bekes.net',
      'gendy@cmplr.eg',
    },
    'passwords': {
      '12345678',
      'hey12345',
      'sad43210',
      'Anime6420',
    },
    'names': {'burh', 'nerd', 'kak', 'AAA'}
  };

  /// Puts both emails and passwords into a map where the key is the email
  /// and the value is the password.
  // I just didn't want to repeat the same data in a different structure just
  // for 1 case
  static Map getEmailPassMap() {
    final emailPass = {};
    assert(users['emails']!.length == users['passwords']!.length);
    final mailIter = users['emails']!.iterator;
    final passIter = users['passwords']!.iterator;

    do {
      emailPass[mailIter.current] = passIter.current;
    } while (mailIter.moveNext() && passIter.moveNext());

    return emailPass;
  }

  /// Maps a route to the mock data it's supposed to receive
  static final Map<String, dynamic> _mockData = {
    // Extra signup whenever the user signups with their email
    // and they want to open their activity or profile screen.
    // each set is used to check whether a given email or username
    // is inside it or not.
    PostURIs.signup: {
      // set of registered emails
      'emails': users['emails'],
      // set of used usernames
      'names': users['names']
    },
    PostURIs.login: {
      'google_acount': {
        'email': 'cmplr.mock@gmail.com',
        'password': 'cmplr_mock_flutter'
      },
      'users': getEmailPassMap(),
    },
    // Doesn't use post()
    Routes.signupPreferencesScreen: {
      'preference_names': [
        'Trending',
        'Art',
        'Writing',
        'Books & Libraries',
        'Streaming',
        'Positivity',
        'Aesthetic',
        'Television',
        'Funny',
        'Gaming',
        'Movies',
        'Music',
        'Comics',
        'Fashion'
      ]
    },
    // Doesn't use post()
    Routes.signupPreferencesSearchScreen: {
      'popular_searched_topics': [
        'Barcelona',
        'PSG',
        'Real Madrid',
        'Atletico Madrid',
        'Manchester City',
        'Manchester United',
        'Chelsea',
        'Liverpool',
        'Arsenal',
        'Borussia Dortmund',
        'Inter Milan',
        'Ac Milan',
        'Juventus'
      ],
      'searched_topics': [
        'Atletico Madrid',
        'Manchester City',
        'Manchester United',
        'Chelsea',
        'Borussia Dortmund',
        'Inter Milan',
        'Ac Milan',
      ]
    },
  };

  static const requestSuccess = 200;
  static const insertSuccess = 201;
  static const invalidData = 422;
  static const unauthenticated = 401;

  static const Map<String, String> postHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    //  TODO add authorization header
  };

  // getHeader = postHeader for now until we find a reason to split them
  static const Map<String, String> getHeader = postHeader;

  static const String apiIp = 'http://13.68.206.72/api';

  static Future<http.Response> post(String backendURI, Map params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (backendURI) {
      case PostURIs.signup:
        return signupMailNameVerification(backendURI, params);
      case PostURIs.login:
        return login(backendURI, params);
      case PostURIs.askBlog:
        return askBlog(backendURI, params);
      case PostURIs.post:
        return createNewPost(backendURI, params);
      case PostURIs.reblog:
        return reblogExistingPost(backendURI, params);

      default:
        throw Exception('Invalid request route');
    }
  }

  static Future<http.Response> get(String backendURI, Map params) async {
    switch (backendURI) {
      case GetURIs.posts:
        throw Exception('Not yet implemented');
      default:
        throw Exception('Inavlid GET URI');
    }
  }

  /* ======================================================================== */
  // Post functions
  /* ======================================================================== */

  // TODO: Rename this screen to "extra signup"
  static Future<http.Response> signupMailNameVerification(
      String backendURI, Map params) async {
    if (Flags.mock) {
      final Set emails = _mockData[backendURI]['emails'];
      final Set names = _mockData[backendURI]['names'];

      final registeredEmail = emails.contains(params['Email']);
      final registeredName = names.contains(params['BlogName']);

      final bothFree = !registeredName && !registeredEmail;

      final errors = [];
      if (registeredName) {
        errors.add('Name already taken');
      }
      if (registeredEmail) {
        errors.add('Email already taken');
      }

      final responseCode = bothFree ? requestSuccess : invalidData;
      return http.Response(jsonEncode(errors), responseCode);
    } else {
      final request = http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );

      return request;
    }
  }

  static Future<http.Response> login(String backendURI, Map params) async {
    if (Flags.mock) {
      final email = params['Email'];
      final password = params['Password'];

      final emailsPasswords = _mockData[backendURI]['users'];

      final matchingEmailPasswordCombination =
          emailsPasswords[email] == password;

      if (!matchingEmailPasswordCombination)
        return http.Response('', unauthenticated);

      return http.Response('', requestSuccess);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> askBlog(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response('', 201));
    } else {
      return http.post(Uri.parse(apiIp + PostURIs.getAskBlog(params['BlogId'])),
          headers: postHeader, body: jsonEncode(params)); /* e */
    }
  }

  static Future<http.Response> createNewPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response('', 201));
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
      );
    }
  }

  static Future<http.Response> reblogExistingPost(
      String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response('', 201));
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
      );
    }
  }

  /* ======================================================================== */
  // Get functions
  /* ======================================================================== */

// TODO: add mock data, get them from the controller
  static Future<http.Response> getPosts(String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response('', 200);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: getHeader,
        body: jsonEncode(params),
      );
    }
  }

  /* ======================================================================== */
  // Not in the backend
  /* ======================================================================== */

  // This functionality is not implemeted in the back-end
  static List initialPreferences(String route) {
    return _mockData[route]['preference_names'];
  }

  // This functionality is not implemeted in the back-end
  static List searchedTopics(String route, String topics) {
    return _mockData[route][topics];
  }
}
