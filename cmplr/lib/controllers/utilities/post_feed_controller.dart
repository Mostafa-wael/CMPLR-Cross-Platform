import '../../utilities/custom_widgets/custom_widgets.dart';

import '../../routes.dart';
import 'package:get/get.dart';

class PostFeedController extends GetxController
    with SingleGetTickerProviderMixin {
  List<PostItem> getPosts() {
    return [
      const PostItem(
        name: 'Mostafa',
        profilePhoto: 'lib/utilities/assets/intro_screen/intro_4.jpg',
        postData: 'lib/utilities/assets/intro_screen/intro_3.jpg',
        numNotes: 100,
        hashtags: [
          'Gamadan',
          'Roaan',
          'Hiiii',
          '3azmaaaaaaaaaaaaaaaaaa',
          'Hyhyhy',
          'NNNAAANNNAAAA'
        ],
      ),
      const PostItem(
        name: 'Mostafa',
        profilePhoto: 'lib/utilities/assets/intro_screen/intro_4.jpg',
        postData: 'lib/utilities/assets/intro_screen/intro_3.jpg',
        numNotes: 100,
        hashtags: [
          'Gamadan',
          'Roaan',
          'Hiiii',
          '3azmaaaaaaaaaaaaaaaaaa',
          'Hyhyhy',
          'NNNAAANNNAAAA'
        ],
      )
    ];
  }
}
