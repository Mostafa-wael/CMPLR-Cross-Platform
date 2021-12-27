import '../../views/utilities/hashtag_posts_view.dart';
import 'package:get/get.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class CheckOutTheseTagsElement extends StatelessWidget {
  var width;
  var height;
  var borderRadius;
  var tagName;
  var imgOneURL;
  var imgTwoURL;
  var tagURL;
  var widgetColor;
  var followed;

  var gestureDetectorKey;

  CheckOutTheseTagsElement(
      {required this.width,
      required this.height,
      required this.borderRadius,
      required this.tagName,
      required this.imgOneURL,
      required this.imgTwoURL,
      required this.tagURL,
      required this.widgetColor,
      required this.followed,
      this.gestureDetectorKey,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                                width: Sizing.blockSize * 13,
                                height: Sizing.blockSizeVertical * 8,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Sizing.blockSize * 2),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'lib/utilities/assets/logo/logo_icon.png',
                                      image: imgOneURL,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(
                                width: Sizing.blockSize * 13,
                                height: Sizing.blockSizeVertical * 8,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Sizing.blockSize * 2),
                                    child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'lib/utilities/assets/logo/logo_icon.png',
                                        image: imgTwoURL,
                                        fit: BoxFit.cover)),
                              )
                            ]),
                        SizedBox(
                          height: Sizing.blockSizeVertical * 5,
                          width: Sizing.blockSize * 28,
                          child: (followed == 'true')
                              ? TextButton(
                                  onPressed: () {
                                    // FIXME: follow/unfollow this tag
                                  },
                                  child: Text('Unfollow',
                                      style: TextStyle(color: widgetColor)),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                )
                              : TextButton(
                                  onPressed: () {
                                    // FIXME: follow this tag
                                  },
                                  child: Text('Follow',
                                      style: TextStyle(color: widgetColor)),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                        )
                      ]),
                )),
            onTap: () {
              Get.to(const HashtagPosts(), arguments: tagName);
            }));
  }
}
