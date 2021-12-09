import 'package:flutter/material.dart';

class Sizing {
  static var width;
  static var height;
  static var blockSize;
  static var blockSizeVertical;
  static var fontSize;

  // default scaling values

  static const _defaultWidth = 410;
  static const _defaultHeight = 730;

  static void setFontSize() {
    final difference =
        width > _defaultWidth ? width - _defaultWidth : _defaultWidth - width;
    fontSize = _defaultWidth / 100 + difference / 1000;
  }
}
