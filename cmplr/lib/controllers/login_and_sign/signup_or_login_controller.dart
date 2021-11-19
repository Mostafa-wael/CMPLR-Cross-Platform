import 'package:get/get.dart';
import '../../views/views.dart';

/// Controller for sign up or login page (intro page)
class IntroController extends GetxController {
  Future<void> signIn() async {
    Get.to(
      const LoginEmailOrGoogle(),
      transition: Transition.downToUp,
    );
    update();
  }

  Future<void> signUp() async {
    Get.to(
      const SignupEmailOrGoogle(),
      transition: Transition.downToUp,
    );
    update();
  }
}
