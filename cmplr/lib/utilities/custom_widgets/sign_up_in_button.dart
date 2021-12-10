import '../sizing/sizing.dart';
import 'package:flutter/material.dart';

class SignUpInButton extends StatelessWidget {
  final text;
  final onTap;

  const SignUpInButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: InkWell(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizing.fontSize * 3.715,
              ),
            ),
          ),
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      width: 300,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
