import 'package:flutter/material.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../backend_uris.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeStuffForYou extends StatelessWidget {
  const HomeStuffForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Stuff for you');
    return PostFeed(postFeedTypePage: GetURIs.postStuff);
  }
}
