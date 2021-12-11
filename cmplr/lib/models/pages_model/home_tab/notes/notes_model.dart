// ignore_for_file: prefer_final_locals

import '../../../cmplr_service.dart';
import 'user_note.dart';

class NotesModel {
  final List<UserNote> _comments = [];
  final List<UserNote> _reblogsWithComments = [];
  final List<UserNote> _otherReblogs = [];
  final List<UserNote> _likes = [];

  Future<List<List<UserNote>>> getNotes() async {
    final notes = await CMPLRService.getNotes('/notes');
    print(notes.length);
    for (var i = 0; i < notes.length; i++) {
      switch (notes[i].noteType) {
        case 'comment':
          _comments.add(notes[i]);
          break;
        case 'reblog_with_comment':
          _reblogsWithComments.add(notes[i]);
          break;
        case 'reblog':
          _otherReblogs.add(notes[i]);
          break;
        case 'like':
          _likes.add(notes[i]);
          break;
        default:
          break;
      }
    }
    // ignore: omit_local_variable_types
    List<List<UserNote>> classifiedNotes = [];
    classifiedNotes.add(_comments);
    classifiedNotes.add(_reblogsWithComments);
    classifiedNotes.add(_otherReblogs);
    classifiedNotes.add(_likes);
    // print(classifiedNotes[0].length +
    //     classifiedNotes[1].length +
    //     classifiedNotes[2].length +
    //     classifiedNotes[3].length);
    return classifiedNotes;
  }
}
