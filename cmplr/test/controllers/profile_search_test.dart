import 'dart:math';

import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/views/home_tab/notes_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('profile search', (tester) async {
    Flags.mock = true;

    final controller = ProfileSearchController();
    controller.onInit();

    controller.searchQueryChanged();
    expect(controller.showClearSearchBarIcon.value, false);

    controller.searchBarController.text = 'test search query';
    controller.searchQueryChanged();
    expect(controller.showClearSearchBarIcon.value, true);

    controller.tabController.index = 1;
    expect(controller.searchBarController.text, '');
    expect(controller.showClearSearchBarIcon.value, false);

    controller.searchBarController.text = 'test search query';
    controller.tabController.index = 0;
    expect(controller.searchBarController.text, '');
    expect(controller.showClearSearchBarIcon.value, false);
  });
}
