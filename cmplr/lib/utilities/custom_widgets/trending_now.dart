import '../../controllers/home_tab/explore_controller.dart';
import 'package:get/get.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

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
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text('Trending now',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
