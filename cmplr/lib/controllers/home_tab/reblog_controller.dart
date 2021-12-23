import '../controllers.dart';

class ReblogController extends WritePostController {
  ReblogController(model) : super(model) {
    tagsAlwaysVisible = true;
  }
}
