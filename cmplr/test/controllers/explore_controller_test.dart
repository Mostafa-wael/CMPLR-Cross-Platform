import 'package:cmplr/controllers/home_tab/check_out_these_blogs_element.dart';
import 'package:cmplr/controllers/home_tab/explore_controller.dart';
import 'package:cmplr/flags.dart';
import 'package:cmplr/utilities/sizing/sizing.dart';
import 'package:cmplr/views/utilities/check_out_these_tags_element.dart';
import 'package:cmplr/views/utilities/text_on_image.dart';
import 'package:cmplr/views/utilities/trending_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Explore controller test', (tester) async {
    final mq = MediaQuery(
      child: Container(),
      data: const MediaQueryData(),
    );

    Sizing.width = mq.data.size.width;
    Sizing.height = mq.data.size.height;
    Sizing.blockSize = Sizing.width / 100;
    Sizing.blockSizeVertical = Sizing.height / 100;
    Sizing.setFontSize();

    final exploreController = ExploreController();

    await tester.runAsync(() async {
      exploreController.getTagsYouFollow();
      await tester.pump(const Duration(seconds: 2));

      assert(exploreController.tagsYouFollow.length > 0);
      assert(exploreController.tagsYouFollow[0].runtimeType == TextOnImage);

      final cottList = await exploreController.getCheckOutTheseTags('cott');
      await tester.pump(const Duration(seconds: 2));

      assert(cottList.length > 0);
      assert(cottList[0].runtimeType == CheckOutTheseTagsElement);

      final twcaList = await exploreController.getCheckOutTheseTags('twca');
      await tester.pump(const Duration(seconds: 2));

      assert(twcaList.length > 0);
      assert(twcaList[0].runtimeType == TextOnImage);

      exploreController.getCheckOutTheseBlogs();
      await tester.pump(const Duration(seconds: 2));

      assert(exploreController.checkOutTheseBlogs.length > 0);
      assert(exploreController.checkOutTheseBlogs.first.runtimeType ==
          CheckOutTheseBlogsElement);

      final trendingRowsList = exploreController.getTrending();
      await tester.pump(const Duration(seconds: 2));

      assert(trendingRowsList.length > 0);
      assert(trendingRowsList.first.runtimeType == TrendingRow);
    });
  });
}
