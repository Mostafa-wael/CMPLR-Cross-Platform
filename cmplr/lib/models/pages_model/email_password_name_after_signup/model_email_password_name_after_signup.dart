import '../../../flags.dart';
import 'abs_email_password_name_after_signup.dart';
import 'api_email_password_name_after_signup.dart';
import 'mock_email_password_name_after_signup.dart';

class ModelEmailPasswordNameAfterSignup {
  // Whether we're using the API or mock services
  final AbstractEmailPasswordNameAfterSignup interface = Flags.mock
      ? MockEmailPasswordNameAfterSignupModel()
      : APIEmailPasswordNameAfterSignup();

  bool checkEmailPasswordName(String email, String password, String name) {
    return interface.checkEmailPasswordName(email, password, name);
  }
}
