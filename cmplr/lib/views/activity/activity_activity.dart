import '../../controllers/activity/activity_activity_controller.dart';
import 'package:get/get.dart';

import '../../utilities/custom_widgets/activity_filter_row.dart';

import 'package:flutter_html/shims/dart_ui_real.dart';

import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';

class ActivityActivity extends StatelessWidget {
  const ActivityActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityActivityController>(
      init: ActivityActivityController(),
      builder: (ActivityActivityController controller) => ListView(children: [
        GestureDetector(
            child: Material(
              elevation: 5,
              child: SizedBox(
                height: Sizing.blockSizeVertical * 8,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Sizing.blockSizeVertical * 1,
                      horizontal: Sizing.blockSize * 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.bolt),
                      const Text('All Activity'),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              controller.context = context;
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizing.blockSize * 5),
                ),
                builder: (context) => Column(
                  children: [
                    SizedBox(height: Sizing.blockSizeVertical * 3),
                    Container(
                      width: Sizing.blockSize * 12,
                      height: Sizing.blockSize * 1,
                      //TODO: Link this to theme
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizing.blockSize))),
                    ),
                    SizedBox(height: Sizing.blockSizeVertical * 3),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizing.blockSize * 6,
                              vertical: Sizing.blockSizeVertical * 2),
                          child: Text('Filter by',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizing.fontSize * 5)),
                        )),
                    Container(
                      height: Sizing.blockSize * 0.2,
                      //TODO: Link this to theme
                      color: Colors.grey[800],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizing.blockSize * 4),
                      child: Column(children: controller.getFilters(context)),
                    ),
                  ],
                ),
              );
            })
      ]),
    );
  }
}
