import '../../utilities/custom_widgets/custom_widgets.dart';

import 'package:get/get.dart';

class PostFeedController extends GetxController
    with SingleGetTickerProviderMixin {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<PostItem> posts = [];

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
      ),
      const PostItem(
        name: 'Wael',
        profilePhoto: 'lib/utilities/assets/intro_screen/intro_3.jpg',
        postData: 'lib/utilities/assets/intro_screen/intro_4.jpg',
        numNotes: 100,
        hashtags: ['3azmaaaaaaaaaaaaaaaaaa', 'Hyhyhy', 'NNNAAANNNAAAA'],
      )
    ];
  }

  void initialPosts() async {
    _isLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1500));
    posts += getNewPosts();
    _isLoading = false;
    update();
  }

  void updatePosts() async {
    _isLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1500));
    posts += getNewPosts();
    _isLoading = false;
    update();
  }
}
