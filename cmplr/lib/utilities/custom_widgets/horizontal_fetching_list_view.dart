import 'package:flutter/material.dart';

// invokes `handleScrollNotification` in the given controller whenever
// You scroll to the end.
// The controller should fetch in response.
// `getData` returns the fetched data in whatever widget you want.
// The controller should also contain a scroll controller.
class HorizontalFetchingListView extends StatelessWidget {
  final scrollControler = ScrollController();

  final controller;

  HorizontalFetchingListView({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
            onNotification: controller.handleScrollNotification,
            child: ListView(
              controller: controller.scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: controller.checkOutTheseBlogs,
            )));
  }
}
