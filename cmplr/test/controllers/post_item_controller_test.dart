import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('post_item', (tester) async {
    Flags.mock = true;

    final controller = PostItemController();
    controller.onInit();
  });
}
