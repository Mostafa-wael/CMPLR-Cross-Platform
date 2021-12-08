import 'preference_card.dart';
import 'dart:math';
import '../../../../routes.dart';
import '../../../cmplr_service.dart';

class SignupPreferencesModel {
  final _preferenceColors = [
    0xFF00B8FF,
    0xFF7C5CFF,
    0xFFFF61CF,
    0xFFFE492E,
    0xFFFF8A00,
    0xFFE7D73A,
    0xFF00CF36
  ];

  List getInitialPreferences() {
    final preferenceNames =
        CMPLRService.initialPreferences(Routes.signupPreferencesScreen)
            as List<String>;
    final preferences = [];
    for (var i = 0; i < preferenceNames.length; i++) {
      preferences.add(PreferenceCard(
          color: _preferenceColors[i % _preferenceColors.length],
          preferenceName: preferenceNames[i]));
    }
    return preferences;
  }

  PreferenceCard createNewPreference(String preferenceName) {
    final random = Random();
    return PreferenceCard(
        color: _preferenceColors[random.nextInt(_preferenceColors.length - 1)],
        preferenceName: preferenceName);
  }
}
