import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class TopBlogsElement extends StatelessWidget {
  var width;
  var height;
  var borderRadius;
  var blogName;
  var coverImgURL;
  var blogPicURL;
  var blogPicType;
  var blogTitle;
  var buttonColor;
  var textColor;
  var blogText;
  var imgOneURL;
  var imgTwoURL;
  var imgThreeURL;
  var blogURL;
  var followed;
  var top;

  TopBlogsElement(
      {required this.width,
      required this.height,
      required this.borderRadius,
      required this.blogName,
      required this.coverImgURL,
      required this.blogPicURL,
      required this.blogPicType,
      required this.blogTitle,
      required this.buttonColor,
      required this.textColor,
      required this.blogText,
      required this.imgOneURL,
      required this.imgTwoURL,
      required this.imgThreeURL,
      required this.blogURL,
      required this.followed,
      required this.top,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: GestureDetector(
            child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Sizing.blockSize * 0.1),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * 16 / 60,
                            width: width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(width * 2 / 60),
                                  topRight: Radius.circular(width * 2 / 60),
                                ),
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                  image: coverImgURL,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            color: Colors.black,
                            height: height * 30 / 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width,
                        child: Positioned(
                          top: height * 1 / 60,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                width * 1 / 60, 0, width * 1 / 60, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  blogName,
                                  style:
                                      TextStyle(fontSize: Sizing.fontSize * 3),
                                ),
                                top
                                    ? PopupMenuButton(
                                        itemBuilder: (context) =>
                                            <PopupMenuItem<String>>[
                                          const PopupMenuItem<String>(
                                            child: Text(
                                              'Woosh this away',
                                            ),
                                          ),
                                        ],
                                        icon: const Icon(Icons.close),
                                        onSelected: (context) {
                                          //TODO: Remove this blog
                                        },
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          (followed == 'true')
                                              ? SizedBox(
                                                  width: Sizing.blockSize * 0.1,
                                                )
                                              : SizedBox(
                                                  width: width * 12 / 60,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(clrs[
                                                                  buttonColor]),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text('Follow'),
                                                  ),
                                                ),
                                          PopupMenuButton(
                                            itemBuilder: (context) =>
                                                <PopupMenuItem<String>>[
                                              const PopupMenuItem<String>(
                                                child: Text(
                                                  'Woosh this away',
                                                ),
                                              ),
                                            ],
                                            icon: const Icon(Icons.close),
                                            onSelected: (context) {
                                              //TODO: Remove this blog
                                            },
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                      top
                          ? Positioned(
                              top: height * 10 / 60,
                              left: width * 20 / 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: height * 4 / 60,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                  image: blogPicURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Positioned(
                              top: height * 10 / 60,
                              left: width * 24 / 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: height * 4 / 60,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                  image: blogPicURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Positioned.fill(
                        top: height * 20 / 60,
                        child: Column(
                          children: [
                            Text(
                              blogTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Sizing.fontSize * 4.5,
                                color: clrs[textColor],
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 1 / 60,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Sizing.blockSize, 0, Sizing.blockSize, 0),
                              child: Text(blogText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Sizing.fontSize * 3,
                                      color: clrs[textColor],
                                      overflow: TextOverflow.ellipsis)),
                            ),
                            SizedBox(height: height * 2 / 60),
                            top
                                ? (followed == 'true')
                                    ? SizedBox(
                                        width: width - width * 0.05,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    clrs[buttonColor]),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Unfollow'),
                                        ),
                                      )
                                    : SizedBox(
                                        width: width - width * 0.05,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    clrs[buttonColor]),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Follow'),
                                        ),
                                      )
                                : SizedBox(
                                    height: Sizing.blockSizeVertical * 0.1),
                            SizedBox(height: Sizing.blockSizeVertical),
                            top
                                ? SizedBox(
                                    height: height * 12 / 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgOneURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgTwoURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgThreeURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: height * 17.5 / 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgOneURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgTwoURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 19 / 60,
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'lib/utilities/assets/logo/cmplr_logo_icon.png',
                                            image: imgThreeURL,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            onTap: () {
              //FIXME: Go to tag page
            }));
  }
}

final clrs = {
  'white': Colors.white,
  'grey': Colors.grey,
  'black': Colors.black,
  'brown': Colors.brown,
};
