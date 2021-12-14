import 'package:flutter/material.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../utilities/sizing/sizing.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeStuffForYou extends StatelessWidget {
  const HomeStuffForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostFeed();
  }
}
