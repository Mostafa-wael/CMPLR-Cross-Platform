import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../backend_uris.dart';

import '../flags.dart';
import 'package:http/http.dart' as http;

import 'pages_model/home_tab/notes/user_note.dart';
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
    Routes.notes: {
      'response': {
        'notes': [
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'square',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'Xz'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content':
                'This is a post comment. This is a post comment. This is a post'
                    'comment. This is a post comment. This is a post comment.'
                    'This is a post comment. This is a post comment.'
                    'This is a post comment.'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'comment',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'content': 'This is a post comment'
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'true',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'like',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed',
            'followed': 'false',
          },
          {
            'type': 'reblog',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed'
          },
          {
            'type': 'reblog',
            'avatar_URL':
                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png',
            'avatar_shape': 'circle',
            'blog_name': 'Mostafa',
            'profile_title': 'Mohamed'
          },
        ],
        'total_notes': 21,
      }
    },
  };

  static const requestSuccess = 200;
  static const invalidData = 422;
  static const unauthenticated = 401;

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
      case PostURIs.posts:
        return getPosts(route, params);

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
      return http.post(
        Uri(path: PostURIs.signup),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // TODO add authorization header
        },
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> login(String route, Map params) async {
    if (Flags.mock) {
      final email = params['Email'];
      final password = params['Password'];

      final emailsPasswords = _mockData[route]['users'];

      final matchingEmailPasswordCombination =
          emailsPasswords[email] == password;

      if (!matchingEmailPasswordCombination)
        return http.Response('', unauthenticated);

      return http.Response('', requestSuccess);
    } else {
      return http.post(
        Uri(path: PostURIs.login),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // TODO add authorization header
        },
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> askBlog(String route, Map param) {
    if (Flags.mock) {
      throw Exception();
    } else {
      return http.post(Uri(path: PostURIs.getAskBlog(param['BlogId'])),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // TODO add authorization header
          },
          body: jsonEncode(param)); /* e */
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

// TODO: add mock data, get them from the controller
  static Future<http.Response> getPosts(String route, Map params) async {
    if (Flags.mock) {
      return http.Response('', 200);
    } else {
      return http.post(
        Uri(path: PostURIs.signup),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // TODO add authorization header
        },
        body: jsonEncode(params),
      );
    }
  }

  static Future<List<UserNote>> getNotes(String route) async {
    final notes = <UserNote>[];
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      for (var i = 0; i < _mockData[route]['response']['total_notes']; i++) {
        notes.add(UserNote.fromJson(_mockData[route]['response']['notes'][i]));
      }
      return notes;
    } else {
      // TODO: Do a get request
      return notes;
    }
  }
}
