import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finalyear/domain/signin/loginREsponse/loginResponse.dart';
import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// class LoginApi {
//   Future<bool> login(LoginModel user) async {
//     bool isLogin = false;
//     Response response;
//     var url = baseUrl + loginUrl;
//     var dio = HttpServices().getDioInstance();

//     try {
//       response = await dio.post(
//         url,
//         data: user.toJson(),
//       );
//       if (response.statusCode == 200) {
//         print("status code200");
//         print("Response data isss loginAPi: ${response.data}");

//         // LoginResponse loginResponse = LoginResponse.fromJson(response.data);

//         // String? token = loginResponse.jwtToken!.access;
//         // print("Token is $token");
//         // if (token != null) {
//         //   isLogin = true;
//         // }

//         return true;
//       } else {
//         debugPrint("Received status code: ${response.statusCode}");
//         debugPrint("Response data: ${response.data}");
//       }
//     } catch (e) {
//       debugPrint("Error: ${e.toString()}");
//     }

//     return isLogin;
//   }

class LoginApi {
  Future<bool> login(LoginModel user) async {
    bool isLogin = false;
    var url = baseUrl + loginUrl;
    var dio = HttpServices().getDioInstance();

    try {
      Response response = await dio.post(
        url,
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        print("status code 200");
        print("Response data from login API: ${response.data}");

        // Parse response data as a Map
        Map<String, dynamic> responseData = response.data;

        // Check if 'success' key exists in the response data
        if (responseData.containsKey('success')) {
          // Access the value corresponding to the 'success' key
          bool successValue = responseData['success'];

          if (successValue) {
            // If login is successful, extract the token
            String? token = responseData['token'];
            print("Token is $token");

            if (token != null) {
              isLogin = true;
            }
          } else {
            // If login is unsuccessful, print the error message
            print("Login failed. Reason: ${responseData['message']}");
          }
        } else {
          // Handle the case where 'success' key is missing in responseData
          print("Response data does not contain 'success' key.");
        }
      } else {
        print("Received status code: ${response.statusCode}");
        print("Response data: ${response.data}");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
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
        debugPrint(
            "Received status code forgotpassword: ${response.statusCode}");
        debugPrint("Response data forgotpassword: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isForgot;
  }
}
