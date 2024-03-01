import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class UserAPI {
  Future<bool> register(SignUpModel user) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        print("Response data isss signUPAPi: ${response.data}");
        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isRegister;
  }
}
