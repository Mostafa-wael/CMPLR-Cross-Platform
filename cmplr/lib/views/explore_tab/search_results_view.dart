import '../utilities/utility_views.dart';

import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';

/// the search results page view
class SearchResultsView extends StatelessWidget {
  const SearchResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchController(),
      builder: (SearchController controller) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  // TODO: Change this to use theme data
                  child: Row(
                    children: [
                      const Icon(
                        Icons.show_chart,
                        color: Colors.white,
                      ),
                      SizedBox(width: Sizing.blockSize),
                      const Text(
                        'Top',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      SizedBox(width: Sizing.blockSize),
                      const Text(
                        'Recent',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.tag,
                        color: Colors.white,
                      ),
                      SizedBox(width: Sizing.blockSize),
                      const Text(
                        'Tagged',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      SizedBox(width: Sizing.blockSize),
                      const Text(
                        'Cmplrs',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            leading: IconButton(
              icon: Icon(
                  Icons.arrow_back, //TODO: Make the color according to theme
                  size: Sizing.blockSize * 5,
                  color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Sizing.blockSize * 1, 0, Sizing.blockSize * 1, 0),
                child: SizedBox(
                  width: Sizing.blockSize * 60,
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) => {controller.returnToSearch()},
                      child: TextField(
                        controller: controller.searchBarController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
              ),
              controller.isFollowed
                  ? ElevatedButton(
                      onPressed: () {
                        controller.toggleFollow();
                      },
                      child: const Text('Unfollow'),
                      style: ButtonStyle(
                        // TODO: Make this depend on theme
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(8.0)),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        controller.toggleFollow();
                      },
                      child: const Text('Follow'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(8.0)),
                      ),
                    )
            ],
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Sizing.blockSize * 2,
                              top: Sizing.blockSizeVertical * 2),
                          child: SizedBox(
                            height: Sizing.blockSizeVertical * 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  '''Explore more #${controller.searchBarController.text}''',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: Sizing.blockSizeVertical * 20,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: controller.getExploreMoreTags(),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Sizing.blockSize * 2,
                              top: Sizing.blockSizeVertical * 2),
                          child: SizedBox(
                            height: Sizing.blockSizeVertical * 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  '''Top ${controller.searchBarController.text} blogs''',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Sizing.blockSizeVertical * 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.getTopBlogs(
                                Sizing.blockSize * 60,
                                Sizing.blockSizeVertical * 60,
                                true),
                          ),
                        ),
                        SizedBox(
                          height: Sizing.blockSizeVertical * 4,
                        ),
                      ],
                    ),
                    Container(
                      child: PostFeed(
                        getTag: 'SearchResults1',
                        prefix: 'SearchResults1',
                        postFeedTypePage: '/user/dashboard',
                      ),
                      constraints: BoxConstraints(
                          maxHeight: Sizing.blockSizeVertical * 200),
                    ),
                  ],
                ),
              ),
              PostFeed(
                getTag: 'SearchResults2',
                postFeedTypePage: '/user/dashboard',
                prefix: 'SearchResults2',
              ),
              PostFeed(
                getTag: 'SearchResults3',
                postFeedTypePage: '/user/dashboard',
                prefix: 'SearchResults3',
              ),
              SizedBox(
                height: Sizing.blockSizeVertical * 50,
                child: ListView(
                  itemExtent: Sizing.blockSizeVertical * 53.85,
                  scrollDirection: Axis.vertical,
                  children: controller.getTopBlogs(Sizing.blockSize * 98,
                      Sizing.blockSizeVertical * 68, false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
