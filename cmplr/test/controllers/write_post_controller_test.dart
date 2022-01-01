import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('WritePostController test', (tester) async {
    final writePostController = WritePostController(const WritePostModel());

    await tester.runAsync(() async {
      writePostController.onTagEnter('Test###');
      assert(writePostController.tags.length == 1);
      assert(writePostController.tags[0] == 'Test');

      writePostController.onTagEnter('T#es###t');
      assert(writePostController.tags.length == 2);
      assert(writePostController.tags[1] == 'Test');

      writePostController.onTagEnter('#####test');
      assert(writePostController.tags.length == 3);
      assert(writePostController.tags[2] == 'test');

      writePostController.onTagEnter('#######');
      assert(writePostController.tags.length == 3);
      assert(writePostController.tags[2] == 'test');
    });
  });
}
