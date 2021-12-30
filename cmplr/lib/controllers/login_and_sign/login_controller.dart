import 'package:get_storage/get_storage.dart';

import '../../utilities/authentication/authentication.dart';

import '../../models/persistent_storage_api.dart';

import '../../utilities/functions.dart';
import '../../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../views/views.dart';

class LoginController extends GetxController {
  // controller for the email text field
  TextEditingController emailController = TextEditingController();

  // controller for the password text field
  TextEditingController passwordController = TextEditingController();

  // whether to hide the password characters in the password text field or not
  bool _hidePassword = true;

  // an instance of the model for login. It handles the validation of email and
  // password
  final ModelEmailPasswordLogin _model = ModelEmailPasswordLogin();

  // whether to show the clear Icon at the end of the text field or not
  bool _showClearIcon = false;

  // tracks the activation of the Login button
  bool _activateLoginButton = false;

  // tracks the activation of the submit password reset request button
  bool _activateSubmitButton = false;

  // tracks whether the email is a valid login email (registered)
  bool _validLoginEmail = false;

  var _googleToken;

  bool get validLoginEmail => _validLoginEmail;

  bool get showClearIcon => _showClearIcon;

  bool get hidePassword => _hidePassword;

  bool get activateLoginButton => _activateLoginButton;

  bool get activateSubmitButton => _activateSubmitButton;

  List errors = [];

  FocusNode passwordFocusNode = FocusNode();

  /// This method navigates from the first login screen
  /// to the email login screen. It does this by first
  /// navigating to a splash screen for 0.5 seconds then
  /// to the email login screen
  Future<void> loginEmail() async {
    Get.to(
      const LoginEmailSplash(),
      transition: Transition.rightToLeft,
      routeName: Routes.loginEmailSplash,
    );
    update();

    Future.delayed(const Duration(milliseconds: 500), () {
      Get.off(
        const LoginEmail(),
        routeName: Routes.loginEmail,
      );
    });
  }

  /// This method navigates from the email login screen to
  /// a screen where the user can click the 'Enter Password' button
  Future<List> tryLogin() async {
    errors = await _model.checkEmailPasswordCombination(
        emailController.text, passwordController.text);

    if (errors.isEmpty) {
      // Log in
      PersistentStorage.changeLoggedIn(true);

      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
    }

    update();
    return errors;
  }

  Future<void> focusOnPassword() async {
    await Future.delayed(const Duration(milliseconds: 2000))
        .then((value) => passwordFocusNode.requestFocus());
  }

  /// This method navigates to the last screen in the login with email process
  /// where the user can enter their email and password
  Future<void> enterPasswordLoginEmail() async {
    if (emailController.text.isEmpty) {
      _showToast('Oops! You forgot to enter your email address!');
    } else {
      Get.off(
        const LoginEmailPassword(),
        transition: Transition.downToUp,
        routeName: Routes.loginEmailPassword,
      )!
          .then((value) => focusOnPassword());
    }

    update();
  }

  // This method navigates from the email login screen to
  /// a screen where the user can click the 'Enter Password' button
  Future<void> continueLoginEmail() async {
    Get.toNamed(Routes.loginEmailContinue);
  }

  /// This method handles the backtrack from the
  /// screen with the 'Enter Password' button to
  /// the first screen in the login process
  Future<void> returnFromContinueLoginEmail() async {
    Get.until(
      (route) => Get.currentRoute == Routes.loginEmail,
    );
    update();
  }

  /// This method checks if the current page is the same as the send page
  bool isCurrentPage(String page) {
    return Get.rawRoute!.settings.name == page;
  }

  /// This method handles the email field text changes & updates the widget
  Future<void> emailFieldChanged() async {
    if (Get.rawRoute != null && isCurrentPage(Routes.loginEmailContinue)) {
      returnFromContinueLoginEmail();
    }

    if (emailController.text.isNotEmpty)
      _showClearIcon = true;
    else
      _showClearIcon = false;

    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);

    _activateSubmitButton = emailController.text.isNotEmpty;
    _validLoginEmail = validateEmail(emailController.text);

    update();
  }

  /// This method handles the password field text changes & updates the widget
  Future<void> passwordFieldChanged() async {
    _activateLoginButton =
        (emailController.text.isNotEmpty && passwordController.text.isNotEmpty);

    update();
  }

  /// This method navigates to the forgot password screen
  Future<void> forgotPassword() async {
    Get.to(const ForgotPassword(),
        transition: Transition.noTransition, routeName: Routes.forgotPassword);
    update();
  }

  /// This method navigates to post forgot password screen where
  /// the user is informed that an email was sent to them
  Future<void> sendResetEmail() async {
    if (!validateEmail(emailController.text)) {
      {
        _showToast(
            'This doesn\'t look like an email address... check it again?');
        // Message Below Text field
        // "That email doesn't have a Tumblr account. Sign up now?"
      }
    } else {
      // TODO: Send email
      Get.off(
        const PostForgotPassword(),
        transition: Transition.noTransition,
        routeName: Routes.postForgotPassword,
      );
    }
  }

  /// This method handles logging in with google
  Future<List> loginGoogle(BuildContext context) async {
    await Authentication.initializeFirebase();
    _googleToken = await Authentication.signInWithGoogle(context: context);
    final response = await _model.loginGoogle(_googleToken);
    if (response.isEmpty) {
      // Log in
      PersistentStorage.changeLoggedIn(true);

      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
    } else if (response[0] == 'you should register first')
      Get.to(const LoginSignupAgeGoogle());

    update();
    return response;
    // if (user != null) {
    //   PersistentStorage.changeLoggedIn(true);
    //   Get.offAll(
    //     const MasterPage(),
    //     transition: Transition.rightToLeft,
    //     routeName: Routes.masterPage,
    //     arguments: user,
    //   );
    // } else {
    //   _showToast('Failed to Login, please try again');
    // }
  }

  Future<void> signUpEmail() async {
    Get.to(
      const SignupAge(),
      transition: Transition.rightToLeft,
    );
    update();
  }

  Future<List> signupGoogle(BuildContext context) async {
    await Authentication.initializeFirebase();
    final response = await _model.signupGoogle(
        _googleToken, ageController.text, signupGoogleController.text);
    if (response.isEmpty) {
      // Log in
      PersistentStorage.changeLoggedIn(true);

      Get.offAll(
        const MasterPage(),
        transition: Transition.rightToLeft,
      );
    }

    update();
    return response;
  }

  /// This method toggles the visibility of the password text field
  Future<void> viewHidePassword() async {
    _hidePassword = !_hidePassword;
    update();
  }

  /// This method handles navigating back from the post forgot password screen
  /// to the screen where the user enters their email/password combination to
  /// log in
  Future<void> returnFromSendResetEmail() async {
    // (Tarek) TODO: Make sure this works
    Get.until((route) => Get.currentRoute == Routes.loginEmailPassword);
    update();
  }

  /// This method handles the validation of the user email/password combination
  /// and if the combination is valid, it navigates to the home page
  // Future<void> enterPassword() async {
  //   if () {
  //     GetStorage().write('logged_in', true);
  //     Get.offAll(
  //       const MasterPage(),
  //       transition: Transition.rightToLeft,
  //     );
  //   } else {
  //     // TODO: Replace this will a message below the text field
  //     _showToast('Incorrect email address or password. Please try again');
  //   }
  //   update();
  // }

  final signupGoogleController = TextEditingController();

  final _ageController = TextEditingController();

  // focus controller for the age text field
  final _focusNode = FocusNode();

  // the color of 'next' button (it changes with the input of the text field)
  int _nextButtonColor = 0xFF015887;

  // determine whether the 'next' button is activated or not
  bool _nextButtonActivated = false;

  // the button which clears the age text field
  bool _showClearButton = false;

  // determines whether the screen is loading or not
  bool _isLoading = false;

  // getters for class attributes
  TextEditingController get ageController => _ageController;

  int get nextButtonColor => _nextButtonColor;

  bool get nextButtonActivated => _nextButtonActivated;

  bool get showClearButton => _showClearButton;

  bool get isLoading => _isLoading;

  FocusNode get focusNode => _focusNode;

  /// This function is called whenever the age changes,
  /// It handles the different scenarios of the age text field
  void ageFieldChanged() {
    // empty text field
    if (_ageController.text == '') {
      _showClearButton = false;
      _nextButtonColor = 0xFF015887;
      _nextButtonActivated = false;
    } else {
      _showClearButton = true;
      final age = int.parse(_ageController.text);

      // age constraints
      if (age < 15 || age > 120) {
        _nextButtonColor = 0xFF015887;
        _nextButtonActivated = false;
      } else {
        _nextButtonColor = 0xFF00B7FE;
        _nextButtonActivated = true;
      }
    }
    update();
  }

  /// This is called when the user presses on 'next' button, it sets the screen
  /// status to be 'loading' so that the progress indicator appears and if the
  /// entered age is appropriate, it redirects the user to the next screen
  void nextButtonPressed() async {
    if (_nextButtonActivated) {
      _isLoading = true;
      _focusNode.unfocus();
      update();

      //TODO: communicate with the API instead of delay
      await Future.delayed(const Duration(seconds: 1));

      if (int.parse(ageController.text) < 13) {
        _isLoading = false;
        _showToast('Minor hiccup. Try again.');
      } else {
        GetStorage().write('age', ageController.text);
        Get.offNamed(Routes.signupPreferencesScreen);
      }
      update();
    }
  }

  void closeAgeScreen() {
    Get.back();
  }
}

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
