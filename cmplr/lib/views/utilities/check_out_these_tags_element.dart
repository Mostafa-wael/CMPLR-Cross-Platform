import '../../controllers/controllers.dart';

import '../../backend_uris.dart';
import '../../models/cmplr_service.dart';
import '../../flags.dart';
import 'hashtag_posts_view.dart';
import '../../utilities/sizing/sizing.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// View for Explore-Check out these tags.
///
/// Holds the tag's name, 2 post previews, and a follow button.
class CheckOutTheseTagsElement extends StatelessWidget {
  var width;
  var height;
  var borderRadius;
  var tagName;
  var imgOneURL;
  var imgTwoURL;
  var widgetColor;

  var gestureDetectorKey;
  final Map? otherData;

  var index;

  CheckOutTheseTagsElement(
      {required this.width,
      required this.height,
      required this.borderRadius,
      required this.tagName,
      required this.imgOneURL,
      required this.imgTwoURL,
      required this.widgetColor,
      this.gestureDetectorKey,
      this.otherData,
      this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerTag = 'CheckOutTheseTagsController$index';
    final controller =
        Get.put(CheckOutTheseTagsElementController(), tag: controllerTag);

    return GetBuilder<CheckOutTheseTagsElementController>(
      tag: controllerTag,
      init: controller,
      builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: GestureDetector(
              key: gestureDetectorKey,
              child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: widgetColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Sizing.blockSize * 1.5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Sizing.blockSizeVertical,
                                  bottom: Sizing.blockSizeVertical),
                              child: Text(
                                tagName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Sizing.blockSize * 12,
                                  height: Sizing.blockSizeVertical * 7,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Sizing.blockSize * 2),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: placeHolderImgPath,
                                        image: imgOneURL,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: Sizing.blockSize * 12,
                                  height: Sizing.blockSizeVertical * 7,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Sizing.blockSize * 2),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: placeHolderImgPath,
                                          image: imgTwoURL,
                                          fit: BoxFit.cover)),
                                )
                              ]),
                          SizedBox(
                              height: Sizing.blockSizeVertical * 5,
                              width: Sizing.blockSize * 28,
                              child: TextButton(
                                onPressed: () {
                                  controller.followUnfollow(tagName);
                                },
                                child: Text(
                                    controller.followed ? 'Unfollow' : 'Follow',
                                    style: TextStyle(color: widgetColor)),
                                style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ))
                        ]),
                  )),
              onTap: () {
                Get.to(const HashtagPosts(), arguments: tagName);
              })),
    );
  }
}

class CheckOutTheseTagsElementController extends GetxController {
  var followed = false;

  void followUnfollow(String tagName) {
    if (followed)
      CMPLRService.unfollowTag(DeleteURIs.unfollowTag, {'tag_name': tagName})
          .then((http.Response response) {
        if (response.statusCode == CMPLRService.requestSuccess) {
          followed = false;
          update();
        }
      });
    else
      CMPLRService.followTag(PostURIs.followTag, {'tag_name': tagName})
          .then((http.Response response) {
        if (response.statusCode == CMPLRService.requestSuccess) {
          followed = true;
          update();
        }
      });
  }
}
