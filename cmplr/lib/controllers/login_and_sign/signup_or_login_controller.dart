import 'package:get/get.dart';
import '../../views/views.dart';

/// Controller for sign up or login page (intro page)
class IntroController extends GetxController {

  /// Navigates to the first screen in the login process
  Future<void> signIn() async {
    Get.to(
      const LoginEmailOrGoogle(),
      transition: Transition.downToUp,
    );
    update();
  }

  /// Navigates to the first screen in the sign up process
  Future<void> signUp() async {
    Get.to(
      const SignupEmailOrGoogle(),
      transition: Transition.downToUp,
    );
    update();
  }
}
