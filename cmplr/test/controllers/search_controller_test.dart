import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/views/home_tab/notes_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('search', (tester) async {
    Flags.mock = true;

    final controller = SearchController();
    controller.onInit();

    controller.searchQueryChanged();
    expect(controller.showClearSearchBarIcon.value, false);

    controller.searchBarController.text = 'test search query';
    controller.searchQueryChanged();
    expect(controller.showClearSearchBarIcon.value, true);
  });
}
