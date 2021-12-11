import 'dart:async';
import 'dart:convert';

import '../backend_uris.dart';

import '../flags.dart';
import 'package:http/http.dart' as http;
import '../routes.dart';
import 'notes_mock_data.dart';

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
    GetURIs.postFollow: {
      'response': {
        'total_posts': 2,
        'posts': [
          {
            'name': 'Mostafa',
            'postID': '1231465396890',
            'reblogKey': 'sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU',
            'profilePhoto': 'lib/utilities/assets/intro_screen/intro_4.jpg',
            'postData': 'lib/utilities/assets/intro_screen/intro_3.jpg',
            'numNotes': 200,
            'showBottomBar': true,
            'hashtags': [
              'Gamadan',
              'Roaan',
              'Hiiii',
            ],
          },
          {
            'name': 'Wael',
            'postID': '1231465396890',
            'reblogKey': 'sDFSDFSDfWefWEfwefwefbhFGhGkFlyFU',
            'profilePhoto': 'lib/utilities/assets/intro_screen/intro_3.jpg',
            'postData': 'lib/utilities/assets/intro_screen/intro_4.jpg',
            'numNotes': 100,
            'showBottomBar': true,
            'hashtags': ['3azmaaaaaaaaaaaaaaaaaa', 'Hyhyhy', 'NNNAAANNNAAAA']
          }
        ]
      }
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
  static const invalidData = 422;
  static const unauthenticated = 401;
  static const insertSuccess = 201;

  static const Map<String, String> postHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    //  TODO add authorization header
  };

  // getHeader = postHeader for now until we find a reason to split them
  static const Map<String, String> getHeader = postHeader;

  static const String apiIp = 'http://13.68.206.72/api';
  // static const String apiIp = 'http://be0b-156-215-2-141.ngrok.io/api';

  static Future<http.Response> post(String route, Map params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case PostURIs.signup:
        return signupMailNameVerification(route, params);
      case PostURIs.login:
        return login(route, params);
      case PostURIs.askBlog:
        return askBlog(route, params);
      default:
        throw Exception('Invalid request route');
    }
  }

  static Future<http.Response> get(String route, Map params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case GetURIs.postFollow:
        return getPosts(route, params);
      case GetURIs.notes:
        return getNotes(route, params);

      default:
        throw Exception('Invalid request route');
    }
  }

  // TODO: Rename this screen to "extra signup"
  static Future<http.Response> signupMailNameVerification(
      String backendURI, Map params) async {
    if (Flags.mock) {
      final Set emails = _mockData[backendURI]['emails'];
      final Set names = _mockData[backendURI]['names'];

      final response = {};
      final errors = {};
      response['error'] = errors;

      final registeredEmail = emails.contains(params['email']);
      final registeredName = names.contains(params['blog_name']);

      if (registeredEmail) {
        errors['email'] = [];
        errors['email'].add('The email has already been taken');
      }
      if (registeredName) {
        errors['blog_name'] = [];
        errors['blog_name'].add('The blog name has already been taken');
      }

      final bothFree = !registeredName && !registeredEmail;
      if (bothFree) {
        emails.add(params['email']);
        names.add(params['blog_name']);
      }

      final responseCode = bothFree ? insertSuccess : invalidData;
      return http.Response(jsonEncode(response), responseCode);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> login(String backendURI, Map params) async {
    if (Flags.mock) {
      final email = params['email'];
      final password = params['password'];

      final emailsPasswords = _mockData[backendURI]['users'];

      final matchingEmailPasswordCombination =
          emailsPasswords[email] == password;

      if (!matchingEmailPasswordCombination)
        return http.Response(
            jsonEncode({
              'error': ['UnAuthorized']
            }),
            unauthenticated);

      return http.Response(jsonEncode({}), requestSuccess);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> askBlog(String backendURI, Map param) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), 201));
    } else {
      return http.post(Uri(path: PostURIs.getAskBlog(param['BlogId'])),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // TODO add authorization header
          },
          body: jsonEncode(param)); /* e */
    }
  }

  static Future<http.Response> createNewPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), 201));
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
      return Future.value(http.Response(jsonEncode({}), 201));
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
      );
    }
  }

  // This functionality is not implemeted in the back-end
  static List initialPreferences(String route) {
    return _mockData[route]['preference_names'];
  }

  // This functionality is not implemeted in the back-end
  static List searchedTopics(String route, String topics) {
    return _mockData[route][topics];
  }

  // ToDo: should be a Get request
  static Future<http.Response> getPosts(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      print('service');
      final res = _mockData[GetURIs.postFollow]['response'];
      return http.Response(
          jsonEncode(_mockData[GetURIs.postFollow]['response']),
          requestSuccess);
    } else {
      return http.Response(
          jsonEncode(_mockData[GetURIs.postFollow]['response']),
          requestSuccess);
    }
  }

  // ToDo: should be a Get request
  static Future<http.Response> getNotes(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(
          jsonEncode(notesMockData['response']), requestSuccess);
    } else {
      return http.Response(
          jsonEncode(notesMockData['response']), requestSuccess);
    }
  }
}
