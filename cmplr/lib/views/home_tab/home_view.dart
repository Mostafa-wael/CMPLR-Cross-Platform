import 'package:flutter/material.dart';
import '../views.dart';

/// The home screen, it has 2 tabs: Following and stuff for you
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    labelColor: Colors.lightBlue[800],
    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    indicatorSize: TabBarIndicatorSize.label,
    unselectedLabelColor: Colors.grey,
    indicatorPadding: const EdgeInsets.all(0),
    tabs: _tabs,
    onTap: (int index) {
      print('Tab $index is tapped');
    },
  );
}

const List<Tab> _tabs = [
  Tab(text: 'Following', key: ValueKey('HomeFollowing')),
  Tab(text: 'Stuff for you', key: ValueKey('HomeStuffForYou'))
];
List<Widget> _views = [
  const HomeFollowing(),
  const HomeStuffForYou(),
];
