import 'signup_preferences_search_api_service.dart';
import 'signup_preferences_search_mock_service.dart';

class SignupPreferencesSearchModel {
  final SignupPreferencesSearchMockService _mockService =
      SignupPreferencesSearchMockService();

  List getPopularSearchedTopics() {
    return _mockService.getPopularSearchedTopics();
  }
}
