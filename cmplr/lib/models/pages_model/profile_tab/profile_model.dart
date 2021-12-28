import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:convert';
import '../../../backend_uris.dart';

import '../../cmplr_service.dart';

class ModelProfile {
  var blogId;
  ModelProfile({required this.blogId}) {}

  Future<dynamic> getBlogInfo() async {
    final response = await CMPLRService.get(GetURIs.blogInfo, {});
    final responseBody = jsonDecode(response.body);
    return responseBody['response'];
  }
}
