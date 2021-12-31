import '../../controllers/home_tab/explore_controller.dart';
import 'package:get/get.dart';

import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';

/// the trernding now item
class TrendingNow extends StatelessWidget {
  const TrendingNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      builder: (ExploreController controller) => ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Sizing.blockSize * 2),
            child: SizedBox(
              height: Sizing.blockSizeVertical * 5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Trending now',
                    style: TextStyle(
                        color: Get.theme.textTheme.bodyText1?.color,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            children: controller.getTrending(),
          )
        ],
      ),
    );
  }
}
