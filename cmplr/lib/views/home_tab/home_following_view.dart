import 'package:flutter/material.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../utilities/sizing/sizing.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeFollowing extends StatelessWidget {
  const HomeFollowing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Following');
    return PostFeed(
      postFeedTypePage: 'dashboard',
    );
  }
}
