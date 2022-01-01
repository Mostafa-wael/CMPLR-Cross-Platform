// ignore_for_file: prefer_single_quotes, unnecessary_string_escapes,
// no_duplicate_case_values

import 'dart:async';
import 'dart:convert';

import '../utilities/user.dart';

import 'package:get_storage/get_storage.dart';

import '../backend_uris.dart';

import '../flags.dart';
import 'package:http/http.dart' as http;
import '../routes.dart';
import 'notes_mock_data.dart';
import 'mock_data.dart';

/// Our interface to the backend OR our mock data
class CMPLRService {
  /// Maps a route to the mock data it's supposed to receive

  static String userBlogName = (Flags.mock == true)
      ? '1'
      : GetStorage().read('user')['primary_blog_id'].toString();
  static const requestSuccess = 200;
  static const invalidData = 422;
  static const unauthenticated = 401;
  static const insertSuccess = 201;

  static const String apiIp = 'https://www.cmplr.tech/api';
  static final Map<String, String> postHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',

    // TODO: Change this to the logged user's token
    'Authorization':
        // ignore: lines_longer_than_80_chars
        'Bearer ${GetStorage().read('token')}'
    //  TODO add authorization header
  };
  // getHeader = postHeader for now until we find a reason to split them
  static final Map<String, String> getHeader = postHeader;

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
        return createPost(backendURI, params);
      case PostURIs.reblog:
        return reblogPost(backendURI, params);
      case PostURIs.loginGoogle:
        return loginWithGoogle(backendURI, params);
      case PostURIs.signupGoogle:
        return signupWithGoogle(backendURI, params);
      case PostURIs.imgUpload:
        return uploadImg(backendURI, params);
      case PostURIs.postReply:
        return postReply(backendURI, params);
      case PostURIs.sendMessage:
        return sendMessage(backendURI, params);
      case PostURIs.followBlog:
        return followBlog(backendURI, params);
      default:
        throw Exception('Invalid request route');
    }
  }

  static Future<http.Response> get(
      String route, Map<String, dynamic> params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case GetURIs.postFollowing:
        return getPosts(route, params);
      // ignore: no_duplicate_case_values
      case GetURIs.postStuff:
        return getPosts(route, params);
      case GetURIs.trendingPosts:
        return getPosts(route, params);
      case GetURIs.notes:
        return getNotes(route, params);
      case GetURIs.blogInfo:
        return getBlogInfo('/blog/' + userBlogName + '/info', params);
      case GetURIs.userTheme:
        return getUserTheme(route, params);
      case GetURIs.activityNotifications:
        return getActivityNotifications(route, params);
      case GetURIs.postByName:
        return getPostByName(route + '/' + params['blogName'], params);

      case GetURIs.userLikes:
        return getUserLikes(route, params);
      case GetURIs.tagsYouFollow:
        return getTagsYouFollow(route);
      case GetURIs.checkOutTheseTags:
        return getCheckoutTheseTags(route);
      case GetURIs.checkOutTheseBlogs:
        return getCheckoutTheseBlogs(route);
      case GetURIs.conversationsList:
        return getConversationsList(route, params);
      case GetURIs.conversationMessages:
        return getConversationMessages(route, params);
      case GetURIs.tryThesePosts:
        return getTryThesePosts(route);
      case GetURIs.followingBlogs:
        return getFollowingBlogs(route, params);
      case GetURIs.hashtagPosts:
        return getHashtagPosts(route, params);
      case GetURIs.tagInfo:
        return getTagInfo(route, params);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> put(
      String route, Map<String, dynamic> params) async {
    // Switch case since we might need to send requests with different
    // content types

    switch (route) {
      case PutURIs.userTheme:
        return putTheme(route, params);
      case GetURIs.activityNotifications:
        return getActivityNotifications(route, params);
      case PutURIs.saveBlogSettings:
        return putBlogSettings(
            route.split(' ')[0] +
                GetStorage().read('user')['blog_name'].toString() +
                route.split(' ')[1],
            params);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> delete(
      String route, Map<String, dynamic> params) async {
    switch (route) {
      case DeleteURIs.unfollowBlog:
        return unfollowBlog(route, params);

      default:
        throw Exception('Invalid request backendURI');
    }
  }

  static Future<http.Response> signupWithGoogle(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  // TODO: Rename this screen to 'extra signup'
  static Future<http.Response> signupMailNameVerification(
      String backendURI, Map params) async {
    if (Flags.mock) {
      final Set emails = mockData[backendURI]['emails'];
      final Set names = mockData[backendURI]['names'];

      final response = {'response': {}};
      final errors = {};
      response['response']?['error'] = errors;

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

  static Future<http.Response> loginWithGoogle(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return http.Response(jsonEncode({}), 200);
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

      final emailsPasswords = mockData[backendURI]['users'];

      final matchingEmailPasswordCombination =
          emailsPasswords[email] == password;

      if (!matchingEmailPasswordCombination)
        return http.Response(
            jsonEncode({
              'error': ['UnAuthorized']
            }),
            unauthenticated);

      return http.Response(
          jsonEncode({
            'user': {
              'blog_name': 'mock', /* TODO: Add more user data? */
            },
          }),
          requestSuccess);
    } else {
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
    }
  }

  static Future<http.Response> getUserTheme(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final res = User.userMap['theme'];
      return http.Response(jsonEncode(res), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      return http.get(
          Uri.parse(apiIp +
              '/blog/' +
              GetStorage().read('user')['primary_blog_id'].toString() +
              '/info'),
          headers: tempHeader);
    }
  }

  static Future<http.Response> putBlogSettings(
      String backendURI, Map params) async {
    if (Flags.mock) {
      // TODO: Change theme
      return http.Response(jsonEncode({}), 200);
    } else {
      return http.put(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> putTheme(String backendURI, Map params) async {
    if (Flags.mock) {
      // TODO: Change theme
      return http.Response(jsonEncode({}), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      return http.put(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
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
    return mockData[route]['preference_names'];
  }

  // This functionality is not implemeted in the back-end
  static List searchedTopics(String route, String topics) {
    return mockData[route][topics];
  }

  static Future<http.Response> getPosts(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[backendURI];
      return http.Response(jsonEncode(res), res['meta']['status_code']);
    } else {
      return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
    }
  }

  static Future<http.Response> getHashtagPosts(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[backendURI];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      final uri = Uri.parse(apiIp + backendURI + '?tag=${params['tag']}');

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> getConversationsList(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[backendURI];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      final uri = Uri.parse(apiIp + backendURI + '/' + params['me']);

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> getPostByName(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[GetURIs.postByName];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
    }
  }

  static Future<http.Response> getConversationMessages(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[backendURI];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      return http.get(
          Uri.parse(
              apiIp + backendURI + '/' + params['me'] + '/' + params['to']),
          headers: getHeader);
    }
  }

  static Future<http.Response> sendMessage(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(
          apiIp + backendURI + '/' + params['me'] + '/' + params['to']);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'Content': params['Content'],
          }));
    }
  }

  static Future<http.Response> getUserLikes(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      final res = await mockData[GetURIs.userLikes];
      return http.Response(jsonEncode(res), requestSuccess);
    } else {
      final tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      return http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
    }
  }

  static Future<http.Response> uploadImg(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      return http.Response(jsonEncode({}), 400);
    } else {
      // ignore: prefer_final_locals
      return http.post(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
    }
  }

  static Future<http.Response> getBlogInfo(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final res = await mockData[GetURIs.blogInfo];
      return http.Response(jsonEncode(res), 200);
    } else {
      // ignore: prefer_final_locals
      var tempHeader = getHeader;
      if (tempHeader['Authorization'] == 'Bearer null')
        tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      final ret =
          await http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
      return ret;
    }
  }

  // ToDo: should be a Get request
  static Future<http.Response> getNotes(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(jsonEncode(notesMockData), requestSuccess);
    } else {
      final uri = Uri.parse(apiIp + backendURI)
          .replace(query: 'post_id=${params['post_id']}');

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> getTagInfo(String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(jsonEncode(notesMockData), requestSuccess);
    } else {
      final uri =
          Uri.parse(apiIp + backendURI).replace(query: 'tag=${params['tag']}');

      return http.get(uri, headers: getHeader);
    }
  }

  static Future<http.Response> createPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else
      return http.post(
        Uri.parse(apiIp + backendURI),
        headers: postHeader,
        body: jsonEncode(params),
      );
  }

  static Future<http.Response> reblogPost(String backendURI, Map params) {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else
      return http.post(Uri.parse(apiIp + backendURI),
          headers: postHeader, body: jsonEncode(params));
  }

  static Future<http.Response> getRecommendedSearchQueries(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(
          jsonEncode(mockData[GetURIs.recommendedSearchQueries]
              ['recommended_search_queries']),
          requestSuccess);
    } else {
      return http.Response(
          jsonEncode(mockData[GetURIs.recommendedSearchQueries]
              ['recommended_search_queries']),
          requestSuccess);
    }
  }

  static Future<http.Response> getFollowingBlogs(
      String backendURI, Map params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));

      return http.Response(jsonEncode(mockData[backendURI]), requestSuccess);
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      final req = await http.get(uri, headers: getHeader);
      print(req.statusCode);
      return req;
    }
  }

  static Future<http.Response> getActivityNotifications(
      String backendURI, Map<String, dynamic> params) async {
    if (Flags.mock) {
      await Future.delayed(const Duration(milliseconds: 1500));
      return Future.value(http.Response(jsonEncode({}), invalidData));
    } else {
      final uri = apiIp + GetURIs.getActivityNotifications(User.blogName);

      return http.get(
        Uri.parse(uri),
        headers: getHeader,
      );
    }
  }

  static Future<http.Response> followBlog(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'blogName': params['blogName'],
          }));
    }
  }

  static Future<http.Response> likePost(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'id': params['id'],
          }));
    }
  }

  static Future<http.Response> unfollowBlog(
      String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      final req = await http.delete(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'blogName': params['blogName'],
          }));
      return req;
    }
  }

  static Future<http.Response> unlikePost(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      final req = await http.delete(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'id': params['id'],
          }));
      return req;
    }
  }

  static Future<http.Response> postReply(String backendURI, Map params) async {
    if (Flags.mock) {
      return Future.value(http.Response(jsonEncode({}), insertSuccess));
    } else {
      final uri = Uri.parse(apiIp + backendURI);

      return http.post(uri,
          headers: getHeader,
          body: jsonEncode(<String, String>{
            'post_id': params['post_id'],
            'reply_text': params['reply_text']
          }));
    }
  }

  static Future<http.Response> getTagsYouFollow(String backendURI) {
    // ignore: prefer_final_locals
    var tempHeader = getHeader;
    if (tempHeader['Authorization'] == 'Bearer null')
      tempHeader['Authorization'] = 'Bearer ${GetStorage().read('token')}';
    return http.get(Uri.parse(apiIp + backendURI), headers: tempHeader);
  }

  static Future<http.Response> getCheckoutTheseTags(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }

  static Future<http.Response> getCheckoutTheseBlogs(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }

  static Future<http.Response> getTryThesePosts(String backendURI) {
    return http.get(Uri.parse(apiIp + backendURI), headers: getHeader);
  }

  static Future<http.Response> unfollowTag(
      String backendURI, Map<String, String> params) {
    return http.delete(Uri.parse(apiIp + backendURI),
        body: jsonEncode(params), headers: postHeader);
  }

  static Future<http.Response> followTag(
      String backendURI, Map<String, String> params) {
    return http.post(Uri.parse(apiIp + backendURI),
        body: jsonEncode(params), headers: postHeader);
  }
}
