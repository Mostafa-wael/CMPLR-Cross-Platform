import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../../routes.dart';

import '../../utilities/custom_widgets/trending_now.dart';

import '../../utilities/custom_widgets/horizontal_fetching_list_view.dart';
import '../../controllers/home_tab/explore_controller.dart';
import 'package:flutter/rendering.dart';
import '../../utilities/sizing/sizing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ExploreController(),
      builder: (ExploreController controller) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: Sizing.blockSizeVertical * 8.0,
              expandedHeight: Sizing.blockSizeVertical * 32.0,
              pinned: true,
              flexibleSpace: SafeArea(
                child: Stack(
                  children: [
                    FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: FittedBox(
                          child: controller.getAppBarBackground(),
                          fit: BoxFit.fitWidth),
                    ),
                    Center(
                      child: SizedBox(
                        width: Sizing.blockSize * 60,
                        height: Sizing.blockSizeVertical * 5.0,
                        child: OutlinedButton(
                          key: const ValueKey('SearchButton'),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.search),
                              Text(
                                'Search CMPLR',
                                style: TextStyle(
                                    color:
                                        Get.theme.textTheme.bodyText1?.color),
                              )
                            ],
                          ),
                          onPressed: () {
                            Get.to(const SearchBar(),
                                routeName: Routes.searchBar);
                          },
                          // FIXME: Make sure this changes
                          // correctly with theme
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizing.blockSizeVertical * 5.0))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: Sizing.blockSizeVertical * 5.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Sizing.blockSize * 2),
                                  child: Text('Tags you follow',
                                      style: TextStyle(
                                          color: Get
                                              .theme.textTheme.bodyText1?.color,
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                    child: const Text('Manage'),
                                    onPressed: () {
                                      // TODO: Go to tag management page
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: controller.tagsYouFollowHeight,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: controller.tagsYouFollow,
                            ),
                          )
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
                                child: Text('Check out these tags',
                                    style: TextStyle(
                                        color: Get
                                            .theme.textTheme.bodyText1?.color,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: controller.checkOutTheseTagsHeight,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: controller.checkOutTheseTags,
                              ))
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
                                child: Text('Check out these blogs',
                                    style: TextStyle(
                                        color: Get
                                            .theme.textTheme.bodyText1?.color,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: controller.checkOutTheseBlogsHeight,
                              child: HorizontalFetchingListView(
                                controller: controller,
                              )),
                        ],
                      ),
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Sizing.blockSize * 2,
                              top: Sizing.blockSizeVertical * 2),
                          child: SizedBox(
                            height: Sizing.blockSizeVertical * 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Try these posts',
                                  style: TextStyle(
                                      color:
                                          Get.theme.textTheme.bodyText1?.color,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Sizing.blockSize * 2),
                          child: controller.tryThesePosts,
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
                                  child: Text('Things We Care About',
                                      style: TextStyle(
                                          color: Get
                                              .theme.textTheme.bodyText1?.color,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: controller.tagsYouFollowHeight,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: controller.thingsWeCareAbout),
                            ),
                            const TrendingNow()
                          ],
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            ))
          ],
        );
      },
    );
  }
}
