import 'package:finalyear/domain/signin/signinApi/signinApi.dart';
import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';

class LoginRepository {
  Future<bool> login(LoginModel user) async {
    return await LoginApi().login(user);
  }

  Future<bool> forgotPassword(String email) async {
    return await LoginApi().forgotPassword(email);
  }
}
