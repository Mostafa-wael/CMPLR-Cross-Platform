import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('signup age', (tester) async {
    Flags.mock = true;

    final controller = SignupPreferencesSearchController();
    controller.onInit();

    controller.searchBarController.text = 'test';
    controller.searchQueryChanged();
    expect(controller.searchIndicatorString, 'Search results');

    controller.searchBarController.text = '';
    controller.searchQueryChanged();
    expect(controller.searchIndicatorString, 'Popular searched topics');
  });
}
