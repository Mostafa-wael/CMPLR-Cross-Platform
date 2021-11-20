import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReblogController extends GetxController {
  bool longPressed = false;

  late FocusNode textFocus;
  String currentMode = 'Regular';
  Map<String, List<String>> textModes = {
    'Regular': ['<p>', '</p>'], // Regular
    'Bigger': ['<h6>', '</h6>'], // Bigger
    'Biggest': ['<h5>', '</h5>'], // Biggest
    'Quote': ['<blockquote>', '</blockquote>'], // Quote
    'Chat': ['', ''], // Chat, note it uses mono
    'Luccile': ['', ''], // Lucille
    'Indent': [
      '<blockquote>',
      '</blockquote>'
    ], // Indented, blockquote seems to do this
    'Bulleted list': ['<ul>', '</ul>', '<li>', '</li>'], // Bulleted list
    'Numbered list': ['<ul>', '</ul>', '<li>', '</li>'], // Numbered list
  };
  ReblogController() {
    textFocus = FocusNode();
  }

  void focusOnText() {
    if (textFocus.hasFocus) {
      // TODO: Cycle modes
    } else
      textFocus.requestFocus();
  }

  Future showFontPopup(context) {
    return showMenu(
      context: context,
      items: [
        PopupMenuItem(
            child: GestureDetector(
          child: const Text('Regular'),
        )),
        PopupMenuItem(
            child: GestureDetector(
          child: const Text('Bigger'),
        ))
      ],
      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
    );
  }

  void setMode(String mode) {
    print(mode);
    assert(textModes.containsKey(mode));
    currentMode = mode;
  }
}
