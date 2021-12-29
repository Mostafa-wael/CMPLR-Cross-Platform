import 'dart:convert';

import 'package:get/get.dart';

import '../../../../flags.dart';
import '../../../../utilities/user.dart';
import '../../../../backend_uris.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';
import 'package:flutter/material.dart';

class ModelEmailPasswordLogin {
  Future<List> signupGoogle(token, age, username) async {
    var errors = [];
    final response = await CMPLRService.post(PostURIs.signupGoogle, {
      'token': token,
      'blog_name': username,
      'age': int.parse(age),
    });

    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode != CMPLRService.insertSuccess) {
      // FIXME: Check for this later on

      if (responseMap.containsKey('error')) {
        final errorMap = responseMap['error'];
        if (errorMap is Map) {
          for (final key in errorMap.keys) {
            errors += errorMap[key];
          }
        } else
          errors = errorMap;
      }
      if (errors.isEmpty) errors.add('Internal server error');
      return errors;
    } else {
      if (!Flags.mock) {
        final userDetails = responseMap['response'];
        User.storeUserData(
          userDetails['blog_name'],
          userDetails['token'],
          userDetails['user'],
        );
        Get.changeThemeMode(userDetails['user']['theme'] == 'trueBlue'
            ? ThemeMode.light
            : ThemeMode.dark);
      }
      return [];
    }
  }

  Future<dynamic> resetPassword(email) async {
    final response = await CMPLRService.forgotPassword(PostURIs.resetPassword, {
      'email': email,
    });
    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    return responseMap;
  }

  Future<List> loginGoogle(token) async {
    final response =
        await CMPLRService.post(PostURIs.loginGoogle, {'token': token});

    final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes));

    // Error should be a map with at most? 3 keys:
    // blog_name, email, and password
    // Each should point to an array of errors, we concatenate them here.

    // Check response for errors

    if (response.statusCode != CMPLRService.requestSuccess) {
      // FIXME: Check for this later on
      var errors = [];
      if (response.statusCode == 401) {
        return ['you should register first'];
      } else {
        if (responseMap.containsKey('error')) {
          final errorMap = responseMap['error'];
          if (errorMap is Map) {
            for (final key in errorMap.keys) {
              errors += errorMap[key];
            }
          } else
            errors = errorMap;
        }
        if (errors.isEmpty) errors.add('Internal server error');
        return errors;
      }
    } else {
      if (!Flags.mock) {
        final userDetails = responseMap['response'];
        User.storeUserData(
          userDetails['blog_name'],
          userDetails['token'],
          userDetails['user'],
        );
        Get.changeThemeMode(userDetails['user']['theme'] == 'trueBlue'
            ? ThemeMode.light
            : ThemeMode.dark);
      }
      return [];
    }
  }

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

    // Check response for errors

    if (response.statusCode != CMPLRService.requestSuccess) {
      // FIXME: Check for this later on

      if (responseMap.containsKey('error')) {
        final errorMap = responseMap['error'];
        if (errorMap is Map) {
          for (final key in errorMap.keys) {
            errors += errorMap[key];
          }
        } else
          errors = errorMap;
      }

      if (errors.isEmpty) errors.add('Internal server error');
      return errors;
    } else {
      if (!Flags.mock) {
        final userDetails = responseMap['response'];
        User.storeUserData(
          userDetails['blog_name'],
          userDetails['token'],
          userDetails['user'],
        );
        Get.changeThemeMode(userDetails['user']['theme'] == 'trueBlue'
            ? ThemeMode.light
            : ThemeMode.dark);
      }
      return [];
    }
  }
}
