import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('signup preferences', (tester) async {
    Flags.mock = true;

    final controller = SignupPreferencesController();
    controller.onInit();

    controller.tapPreferenceCard(0);
    expect(controller.buttonText, 'Pick 4');

    // tap all cards (0 is already tapped before)
    for (var i = 1; i < controller.availablePreferenceCards.length; i++) {
      controller.tapPreferenceCard(i);
    }
    expect(controller.selectedPreferencesCount,
        controller.availablePreferenceCards.length);
    expect(controller.buttonText, 'Next');

    // tap all chosen cards (unselect them)
    for (var i = 0; i < controller.availablePreferenceCards.length; i++) {
      controller.tapPreferenceCard(i);
    }
    expect(controller.selectedPreferencesCount, 0);
  });
}
