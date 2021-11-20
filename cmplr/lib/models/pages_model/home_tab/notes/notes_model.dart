import '../../../../flags.dart';
import 'notes_mock_service.dart';
import 'notes_api_service.dart';
import 'notes_abs.dart';

class NotesModel {
  final NotesAbstract interface =
      Flags.mock ? NotesMockService() : NotesAPIService();

  Future<List> getPostLikes() {
    return interface.getPostLikes();
  }

  Future<List> getNotesCount() {
    return interface.getNotesCount();
  }
}
