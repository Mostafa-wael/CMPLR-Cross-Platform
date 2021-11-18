/// This model holds the data for a preference
class PreferenceCard {
  final color;
  final preferenceName;
  bool isChosen = false;

  PreferenceCard({
    required this.color,
    required this.preferenceName,
  });
}
