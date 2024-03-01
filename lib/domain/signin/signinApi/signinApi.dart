import 'package:dio/dio.dart';
import 'package:finalyear/domain/signin/loginREsponse/loginResponse.dart';
import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LoginApi {
  Future<bool> login(LoginModel user) async {
    bool isLogin = false;
    Response response;
    var url = baseUrl + loginUrl;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        print("status code is ${response.statusCode}");
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        String? token = loginResponse.jwtToken!.access;
        print("Token is $token");
        if (token != null) {
          isLogin = true;
        }
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isLogin;
  }

  Future<bool> forgotPassword(String email) async {
    bool isForgot = false;
    Response response;
    var url = baseUrl + forgotPasswordUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: {"email": email},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isForgot;
  }
}
