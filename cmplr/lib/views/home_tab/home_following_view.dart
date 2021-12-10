import 'package:flutter/material.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeFollowingScreen extends StatefulWidget {
  const HomeFollowingScreen({Key? key}) : super(key: key);

  @override
  _HomeFollowingScreenState createState() => _HomeFollowingScreenState();
}

// TODO: Make it a list
// TODO: get the data from the model
class _HomeFollowingScreenState extends State<HomeFollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return const PostItem(
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
    );
  }
}
