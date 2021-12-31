import 'package:flutter/material.dart';
import '../utilities/utility_views.dart';
import '../../backend_uris.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeFollowing extends StatelessWidget {
  const HomeFollowing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Following');
    return PostFeed(
      postFeedTypePage: GetURIs.postFollowing,
      prefix: 'HomeFollowing',
      getTag: 'HomeFollowing',
    );
  }
}
