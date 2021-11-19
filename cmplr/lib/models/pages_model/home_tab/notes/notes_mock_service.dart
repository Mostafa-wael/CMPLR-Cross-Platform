import 'notes_abs.dart';
import 'user_note.dart';

class NotesMockService implements NotesAbstract {
  final likesCount = 10;
  final notesCount = 100;

  var postLikes = [];
  var avatarURLs = [];
  final tumblrNames = [
    'mostafa',
    'ahmed',
    'mohamed',
    'ziad',
    'mostafa',
    'ahmed',
    'mohamed',
    'ziad',
    'osama',
    'youssef'
  ];
  final profileTitles = [
    'mostafa',
    'ahmed',
    'mohamed',
    'ziad',
    'mostafa',
    'ahmed',
    'mohamed',
    'ziad',
    'osama',
    'youssef'
  ];

  NotesMockService() {
    for (var i = 0; i < likesCount; i++) {
      avatarURLs.add(
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png');
    }
    for (var i = 0; i < likesCount; i++) {
      postLikes.add(UserNote(
          avatarURL: avatarURLs[i],
          profileTitle: profileTitles[i],
          tumblrName: tumblrNames[i]));
    }
  }

  @override
  Future<List> getPostLikes() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return postLikes;
  }
}
