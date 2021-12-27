import 'dart:developer';

import 'text_on_image.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class TrendingRow extends StatelessWidget {
  final rowNum;
  var trendName;
  var trendTags;
  var trendPosts;
  var circleColor;

  TrendingRow({
    required this.rowNum,
    required this.trendName,
    required this.trendTags,
    required this.trendPosts,
    this.circleColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Sizing.blockSize * 5,
                child: CircleAvatar(
                  child: Text(
                    rowNum,
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: Sizing.blockSizeVertical * 1.5),
                  ),
                  backgroundColor: circleColor,
                  radius: Sizing.blockSizeVertical * 1,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: Sizing.blockSizeVertical * 5,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Sizing.blockSizeVertical,
                      bottom: Sizing.blockSizeVertical,
                      left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        trendName,
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // FIXME: Follow trend
                        },
                        child: const Text('Follow'),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Sizing.blockSize * 9,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizing.blockSizeVertical * 4,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: trendTags),
              ),
              SizedBox(
                height: Sizing.blockSizeVertical * 10,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: trendPosts,
                ),
              )
            ],
          ),
        ),
      ]),
      onTap: () {
        //FIXME: Go to tag page
        log('trending block tapped');
      },
    );
  }
}
