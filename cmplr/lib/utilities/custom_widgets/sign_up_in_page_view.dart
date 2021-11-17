import 'package:flutter/material.dart';

class SignUpInPageView extends StatelessWidget {
  List<String> texts;
  List<String> imagePathes;
  final imageChildren = <Widget>[];

  SignUpInPageView({Key? key, required this.texts, required this.imagePathes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);
    var listLength =
        texts.length < imagePathes.length ? texts.length : imagePathes.length;
    for (var i = 0; i < listLength; i++) {
      imageChildren.add(
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Opacity(
              child: Center(
                child: Image(
                  image: AssetImage(imagePathes[i]),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
              opacity: 0.5,
            ),
            Center(
              child: Text(
                texts[i],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
            )
          ],
        ),
      );
    }
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: imageChildren,
    );
  }
}
