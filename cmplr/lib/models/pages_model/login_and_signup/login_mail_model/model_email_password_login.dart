import '../../../../routes.dart';
import '../../../cmplr_service.dart';
import '../../../../utilities/functions.dart';

class ModelEmailPasswordLogin {
  Future<bool> checkEmailPasswordCombination(
      String email, String password) async {
    final validEmail = validateEmail(email);
    if (!validEmail || password.isEmpty) return Future.value(false);

    if (!validEmail) return Future.value(false);

    final response = await CMPLRService.post(
      Routes.loginEmailPassword,
      {
        'Email': email,
        'Password': password,
      },
    );

    return response.statusCode == CMPLRService.requestSuccess;
  }
}
