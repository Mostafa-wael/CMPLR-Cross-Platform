import '../../../../routes.dart';
import '../../../cmplr_service.dart';

class SignupPreferencesSearchModel {
  List searchedTopics(String topic) {
    return CMPLRService.searchedTopics(
        Routes.signupPreferencesSearchScreen, topic);
  }
}
