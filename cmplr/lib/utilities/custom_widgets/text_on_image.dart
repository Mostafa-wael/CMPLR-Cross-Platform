import 'dart:developer';
import 'dart:typed_data';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class TextOnImage extends StatelessWidget {
  final backgroundURL;
  final text;
  final width;
  final height;

  var onTap;
  var showText;
  var showImg;
  var dimImage;
  var maxTextRows;

  double fontSizeScale;
  BorderRadius? borderRadius = BorderRadius.circular(Sizing.blockSize);
  double fontSize = Sizing.blockSizeVertical * 2;

  TextOnImage({
    required this.width,
    required this.height,
    this.backgroundURL,
    this.text,
    this.onTap,
    this.dimImage = true,
    this.borderRadius,
    this.fontSizeScale = 1,
    this.maxTextRows = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: SizedBox(
            width: width,
            height: height,
            child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.zero,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (backgroundURL != null)
                      FadeInImage.assetNetwork(
                        placeholder: 'lib/utilities/assets/logo/logo_icon.png',
                        image: backgroundURL,
                        fit: BoxFit.cover,
                      ),
                    if (dimImage)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    if (text != null)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: maxTextRows,
                            softWrap: true,
                            style:
                                TextStyle(fontSize: (fontSize * fontSizeScale)),
                          ),
                        ),
                      )
                  ],
                )),
          ),
        ),
        onTap: onTap);
  }
}