import 'package:flutter/material.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../utilities/sizing/sizing.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeFollowingScreen extends StatefulWidget {
  const HomeFollowingScreen({Key? key}) : super(key: key);

  @override
  _HomeFollowingScreenState createState() => _HomeFollowingScreenState();
}

class _HomeFollowingScreenState extends State<HomeFollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return const PostFeed();
  }
}
