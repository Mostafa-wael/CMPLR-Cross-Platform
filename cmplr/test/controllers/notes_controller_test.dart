import 'package:cmplr/controllers/controllers.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/views/home_tab/notes_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('notes', (tester) async {
    Flags.mock = true;

    final controller = NotesController();
    controller.onInit();

    controller.commentTextFieldChanged('');
    expect(controller.emptyCommentTextField.value, true);

    controller.addStringToComment('Test comment');
    expect(controller.commentTextFieldController.text, 'Test comment');

    controller.addStringToComment(' + another test');
    expect(controller.commentTextFieldController.text,
        'Test comment + another test');

    controller.commentTextFieldChanged('test');
    expect(controller.emptyCommentTextField.value, false);
    // controller.commentSubmitted();
    // expect(controller.commentTextFieldController.text, '');
    // expect(controller.notes![0][0].postReply, 'Test comment + another test');
    // expect(controller.notes![0][0].noteType, 'reply');
  });
}
