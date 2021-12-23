import 'dart:convert';

import '../../cmplr_service.dart';

class SearchModel {
  Future<List> getRecommendedSearchQueries() async {
    final response =
        await CMPLRService.getRecommendedSearchQueries('/search_bar', {});
    final responseBody = jsonDecode(response.body);
    return responseBody;
  }
}
