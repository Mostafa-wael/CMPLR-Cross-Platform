
// import 'user_note.dart';

// class NotesMockService  {
//   final countList = [10, 15, 10]; //comments count, reblogs count,likes count

//   var postLikes = [];
//   var avatarURLs = [];
//   var avatarShapes = [
//     'square',
//     'square',
//     'circle',
//     'circle',
//     'circle',
//     'circle',
//     'circle',
//     'circle',
//     'circle',
//     'circle'
//   ];
//   final blogNames = [
//     'mostafa',
//     'ahmed',
//     'mohamed',
//     'ziad',
//     'mostafa',
//     'ahmed',
//     'mohamed',
//     'ziad',
//     'osama',
//     'youssef'
//   ];
//   final profileTitles = [
//     'mostafa',
//     'ahmed',
//     'mohamed',
//     'ziad',
//     'mostafa',
//     'ahmed',
//     'mohamed',
//     'ziad',
//     'osama',
//     'youssef'
//   ];

//   NotesMockService() {
//     for (var i = 0; i < countList[2]; i++) {
//       avatarURLs.add(
//           'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/270px-Chelsea_FC.svg.png');
//     }
//     for (var i = 0; i < countList[2]; i++) {
//       postLikes.add(UserNote(
//           avatarURL: avatarURLs[i],
//           avatarShape: avatarShapes[i],
//           profileTitle: profileTitles[i],
//           blogName: blogNames[i]));
//     }
//   }

//   Future<List> getPostLikes() async {
//     await Future.delayed(const Duration(milliseconds: 2000));
//     return postLikes;
//   }

//   Future<List> getNotesCount() async {
//     await Future.delayed(const Duration(milliseconds: 2000));
//     return countList;
//   }
// }
