import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final double underlineDistance, underlineWidth;
  final manager;
  final textController;
  final text;

  LoginTextField({
    this.underlineDistance = 1.0,
    this.underlineWidth = 1.0,
    required this.manager,
    required this.textController,
    required this.text,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: text,
            suffixIcon: textController.text.isNotEmpty ? InkWell(
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onTap: () {
                textController.clear();
                manager.emailFieldChanged();
              },
            ) : const Icon(
              Icons.clear,
              color: Colors.transparent,
            ),
          ),
          controller: textController,
          onChanged: (text) {
            manager.emailFieldChanged();
          },
        ),
      width: 340,
    );
  }
}
