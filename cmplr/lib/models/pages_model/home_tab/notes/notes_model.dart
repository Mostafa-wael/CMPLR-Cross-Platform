// ignore_for_file: prefer_final_locals

import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../cmplr_service.dart';
import 'user_note.dart';

class NotesModel {
  Future<List<List<UserNote>>> getNotes() async {
    var _comments = <UserNote>[];
    var _reblogsWithComments = <UserNote>[];
    var _otherReblogs = <UserNote>[];
    var _likes = <UserNote>[];
    final notes = await CMPLRService.getNotes('/notes');
    for (var i = 0; i < notes.length; i++) {
      switch (notes[i].noteType) {
        case 'reply':
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
    return classifiedNotes;
  }
}
