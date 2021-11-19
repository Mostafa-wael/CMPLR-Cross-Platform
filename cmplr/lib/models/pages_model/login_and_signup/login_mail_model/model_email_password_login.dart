import '../../../../flags.dart';
import 'abs_email_password_login.dart';
import 'api_email_password_login.dart';
import 'mock_email_password_login.dart';

class ModelEmailPasswordLogin {
  // Whether we're using the API or mock services
  final AbstractEmailPasswordLogin interface = Flags.mock
      ? MockEmailPasswordLoginModel()
      : APIEmailPasswordLogin();

  bool checkEmailPasswordCombination(String email, String password) {
    return interface.checkEmailPasswordCombination(email, password);
  }
  bool validateEmail(String email) {
    return interface.validateEmail(email);
  }
  bool validateGoogleAccount(account) {
    return interface.validateGoogleAccount(account);
  }
}
