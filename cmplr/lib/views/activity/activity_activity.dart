import 'package:flutter/material.dart';

class ActivityActivity extends StatelessWidget {
  const ActivityActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      GestureDetector(
        child: Material(
          child: Row(children: [
            const Icon(Icons.bolt),
            const Text('All Activity'),
            const Icon(Icons.keyboard_arrow_down)
          ]),
        ),
      )
    ]);
  }
}
