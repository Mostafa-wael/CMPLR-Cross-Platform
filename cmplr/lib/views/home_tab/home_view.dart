import 'package:flutter/material.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            // leading: IconButton(icon: Icon(Icons.arrow_back)),
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(fit: StackFit.expand, children: <Widget>[
          //  Icon(Icons.home),
          getTabBar(context),
        ]))),
        body: TabBarView(children: _views),
      ),
    );
  }
}

TabBar getTabBar(context) {
  return TabBar(
    indicatorWeight: 1,
    indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
    labelColor: Theme.of(context).textSelectionTheme.selectionColor,
    indicatorSize: TabBarIndicatorSize.label,
    unselectedLabelColor: Colors.grey,
    indicatorPadding: const EdgeInsets.all(0),
    tabs: _tabs,
    onTap: (int index) {
      print('Tab $index is tapped');
    },
  );
}

const List<Tab> _tabs = [Tab(text: 'Following'), Tab(text: 'Stuff for you')];
List<Widget> _views = [
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
  const Tab(text: 'Stuff for you'),
];
