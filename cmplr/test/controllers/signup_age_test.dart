import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('signup age', (tester) async {
    Flags.mock = true;

    final controller = SignupAgeController();

    // age field is empty
    controller.ageFieldChanged();
    expect(controller.showClearButton, false);
    expect(controller.nextButtonColor, 0xFF015887);
    expect(controller.nextButtonActivated, false);

    // next button is disabled
    controller.nextButtonPressed();
    expect(controller.isLoading, false);

    // if the age is 0, the button is not activated,
    // clear button is enabled when there is any text in the field
    controller.ageController.text = '0';
    controller.ageFieldChanged();
    expect(controller.nextButtonActivated, false);
    expect(controller.showClearButton, true);

    // correct age
    controller.ageController.text = '14';
    controller.ageFieldChanged();
    expect(controller.nextButtonActivated, true);
    expect(controller.showClearButton, true);

    // incorrect age, the next button is disabled
    controller.ageController.text = '999';
    controller.ageFieldChanged();
    expect(controller.nextButtonActivated, false);
    expect(controller.showClearButton, true);
  });
}
