import 'preference_card.dart';

class SignupPreferencesMockService {
  final preferenceColors = [
    0xFF00B8FF,
    0xFF7C5CFF,
    0xFFFF61CF,
    0xFFFE492E,
    0xFFFF8A00,
    0xFFE7D73A,
    0xFF00CF36
  ];

  final _preferenceNames = [
    'Trendingaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaxx',
    'Art',
    'Writing',
    'Books & Libraries',
    'Streaming',
    'Positivity',
    'Aesthetic',
    'Television',
    'Funny',
    'Gaming',
    'Movies',
    'Music',
    'Comics',
    'Fashion'
  ];

  List getInitialPreferences() {
    List initialPreferences = [];
    for (int i = 0; i < _preferenceNames.length; i++) {
      final card = PreferenceCard(
          color: preferenceColors[i % preferenceColors.length],
          preferenceName: _preferenceNames[i]);
      initialPreferences.add(card);
    }
    return initialPreferences;
  }
}
