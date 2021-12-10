import '../../../utilities/custom_widgets/post_item.dart';

class ModelPostsFeed {
  // TODO: this function should return list of posts
//   Future<http.Response> getNewPosts(String postType) async {
//     final response = await CMPLRService.post(
//       PostURIs.posts,
//       {
//         'postType': postType,
//       },
//     );
//     // TODO: you should porse the JSON
//     final postMap = jsonDecode(response.body);

//     return postMap;
//   }
// }

  List<PostItem> getNewPosts() {
    return [
      const PostItem(
        name: 'Mostafa',
        profilePhoto: 'lib/utilities/assets/intro_screen/intro_4.jpg',
        postData: 'lib/utilities/assets/intro_screen/intro_3.jpg',
        numNotes: 200,
        hashtags: [
          'Gamadan',
          'Roaan',
          'Hiiii',
        ],
        showBottomBar: true,
      ),
      const PostItem(
        name: 'Wael',
        profilePhoto: 'lib/utilities/assets/intro_screen/intro_3.jpg',
        postData: 'lib/utilities/assets/intro_screen/intro_4.jpg',
        numNotes: 100,
        hashtags: ['3azmaaaaaaaaaaaaaaaaaa', 'Hyhyhy', 'NNNAAANNNAAAA'],
        showBottomBar: true,
      )
    ];
  }
}
