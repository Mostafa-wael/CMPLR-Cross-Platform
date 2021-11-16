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
    return InkWell(
      child: Container(
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        width: 300,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius:  BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onTap: () => onTap,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }
}