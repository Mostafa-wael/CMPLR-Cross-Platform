import 'package:flutter/material.dart';


class SignUpInPageView extends StatelessWidget {
  List<String> texts;
  final children = <Widget>[];

  SignUpInPageView({
    Key? key,
    required this.texts,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    children.add(const SizedBox(height: 220));
    for (String text in texts) {
      children.add(
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        )
      );
      children.add(const SizedBox(height: 10));
    }
    children.add(const SizedBox(height: 320));

    return Stack(
      children: [
        Center(
          child: Column(
          children: children,
          ),
        ),
      ],
    );
  }

}