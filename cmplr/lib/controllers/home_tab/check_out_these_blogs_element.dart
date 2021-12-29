import '../../views/blog/screens/visitor_blog.dart';
import 'package:get/get.dart';

import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';

class CheckOutTheseBlogsElement extends StatelessWidget {
  final width;
  final height;
  final borderRadius;
  final blogName;
  final blogImgURL;
  final blogBgURL;
  final blogImgRadius;
  final blogImgCenterHeightFactor;
  final widgetColor;

  var gestureDetectorKey;
  Map? otherData;

  CheckOutTheseBlogsElement({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.blogName,
    required this.blogImgURL,
    required this.blogBgURL,
    required this.blogImgRadius,
    required this.blogImgCenterHeightFactor,
    required this.widgetColor,
    this.gestureDetectorKey,
    this.otherData,
    Key? key,
  }) : super(key: key);

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
                child: Stack(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizing.blockSize * 2),
                                topRight:
                                    Radius.circular(Sizing.blockSize * 2)),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  'lib/utilities/assets/logo/logo_icon.png',
                              image: blogBgURL,
                              fit: BoxFit.cover,
                              height: height / 3,
                              width: width,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Sizing.blockSizeVertical,
                                bottom: Sizing.blockSizeVertical),
                            child: Text(
                              blogName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ),
                          SizedBox(
                            height: Sizing.blockSizeVertical * 5,
                            width: Sizing.blockSize * 28,
                            child: TextButton(
                              onPressed: () {
                                // FIXME: follow this blog
                              },
                              child: Text('Follow',
                                  style: TextStyle(color: widgetColor)),
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          )
                        ]),
                    FractionallySizedBox(
                      heightFactor: blogImgCenterHeightFactor,
                      child: Center(
                        child: CircleAvatar(
                          radius: height / 8,
                          foregroundImage: FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/logo_icon.png',
                                  image: blogImgURL)
                              .image,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          onTap: () {
            Get.to(
                VisitorBlog(blogId: otherData?['blog_id']?.toString() ?? ''));
          },
        ));
  }
}
