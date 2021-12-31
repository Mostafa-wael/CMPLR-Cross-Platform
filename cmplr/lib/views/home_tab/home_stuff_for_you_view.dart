import 'package:flutter/material.dart';
import '../utilities/utility_views.dart';
import '../../backend_uris.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeStuffForYou extends StatelessWidget {
  const HomeStuffForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Stuff for you');
    return PostFeed(
      getTag: 'StuffForYou',
      postFeedTypePage: GetURIs.postStuff,
      prefix: 'StuffForYou',
    );
  }
}
