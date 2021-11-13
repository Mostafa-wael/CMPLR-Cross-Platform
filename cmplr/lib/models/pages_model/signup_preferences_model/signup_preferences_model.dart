import 'package:cmplr/models/pages_model/signup_preferences_model/preference_card.dart';
import 'dart:math';
import 'signup_preferences_mock_service.dart';
import 'signup_preferences_api_service.dart';

class SignupPreferencesModel {
  SignupPreferencesMockService _mockService = SignupPreferencesMockService();

  List getInitialPreferences() {
    return _mockService.getInitialPreferences();
  }

  PreferenceCard createNewPreference(String preferenceName) {
    final random = new Random();
    return PreferenceCard(
        color: _mockService.preferenceColors[
            random.nextInt(_mockService.preferenceColors.length - 1)],
        preferenceName: preferenceName);
  }
}
