import 'preference_card.dart';
import 'dart:math';
import 'signup_preferences_mock_service.dart';

class SignupPreferencesModel {
  final SignupPreferencesMockService _mockService =
      SignupPreferencesMockService();

  List getInitialPreferences() {
    return _mockService.getInitialPreferences();
  }

  PreferenceCard createNewPreference(String preferenceName) {
    final random = Random();
    return PreferenceCard(
        color: _mockService.preferenceColors[
            random.nextInt(_mockService.preferenceColors.length - 1)],
        preferenceName: preferenceName);
  }
}
