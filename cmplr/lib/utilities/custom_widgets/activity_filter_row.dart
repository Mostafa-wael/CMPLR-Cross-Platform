import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class ActivityFilterRow extends StatelessWidget {
  final icon;
  final rowText;
  final onTap;
  final iconPadding, rowPadding;
  final color;

  const ActivityFilterRow(
      {required this.icon,
      required this.rowText,
      required this.onTap,
      required this.iconPadding,
      required this.rowPadding,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: iconPadding,
            child: Icon(
              icon,
              color: color,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: rowPadding,
              child: Text(
                rowText,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
