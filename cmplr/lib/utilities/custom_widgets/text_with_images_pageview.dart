import 'package:flutter/material.dart';

// This widget is used to generate page view with images and text on it
// ignore: must_be_immutable
class TextWithImagesPageView extends StatelessWidget {
  List<String> texts; // text to show
  List<String> imagePathes; // image paths

  TextWithImagesPageView(
      {Key? key, required this.texts, required this.imagePathes})
      : super(key: key);
  List<Widget> getImageWithTextChildren(listLength, texts, imagePathes) {
    final imageWithText = <Widget>[];
    for (var i = 0; i < listLength; i++) {
      imageWithText.add(
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
    return imageWithText;
  }

  @override
  Widget build(BuildContext context) {
    final listLength =
        texts.length < imagePathes.length ? texts.length : imagePathes.length;
    // controller to manage the page view
    final controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: getImageWithTextChildren(listLength, texts, imagePathes),
    );
  }
}
