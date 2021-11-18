import 'signup_preferences_search_mock_service.dart';

class SignupPreferencesSearchModel {
  final SignupPreferencesSearchMockService _mockService =
      SignupPreferencesSearchMockService();

  List getPopularSearchedTopics() {
    return _mockService.getPopularSearchedTopics();
  }
}
