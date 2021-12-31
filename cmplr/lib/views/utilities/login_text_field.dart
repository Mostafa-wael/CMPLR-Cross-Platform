import '../../utilities/sizing/sizing.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final double underlineDistance, underlineWidth;
  final controller;
  final text;
  final enabled;
  final underlineColor;
  final isEmail;
  final focus;
  final iconColor;
  final textFieldKey;

  const LoginTextField({
    this.underlineDistance = 1.0,
    this.underlineWidth = 1.0,
    required this.controller,
    required this.text,
    required this.focus,
    required this.enabled,
    required this.underlineColor,
    required this.isEmail,
    required this.iconColor,
    required this.textFieldKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController =
        isEmail ? controller.emailController : controller.passwordController;
    return SizedBox(
      child: TextField(
        autofocus: focus,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: isEmail
              ? controller.showClearIcon
                  ? InkWell(
                      child: Icon(
                        Icons.clear,
                        color: iconColor,
                      ),
                      onTap: () {
                        textController.clear();
                        controller.emailFieldChanged();
                      },
                    )
                  : const Icon(
                      Icons.clear,
                      color: Colors.transparent,
                    )
              : InkWell(
                  child: Icon(
                    controller.hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: iconColor,
                  ),
                  onTap: () {
                    controller.viewHidePassword();
                  }),
          enabledBorder: isEmail
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: underlineColor))
              : InputBorder.none,
          focusedBorder: isEmail
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: underlineColor))
              : InputBorder.none,
        ),
        controller: textController,
        onChanged: isEmail
            ? (text) {
                controller.emailFieldChanged();
              }
            : (text) {
                controller.passwordFieldChanged();
              },
        enabled: enabled,
        obscureText: isEmail ? false : controller.hidePassword,
        style: TextStyle(
            fontSize: Sizing.fontSize * 5.6,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
      width: Sizing.blockSize * 80,
    );
  }
}
