import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class AddStaffApi {
  Future<bool> register(AddStaffModel user) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + addStaff;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        print("Response data isss addstaffapi: ${response.data}");
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

// Method to fetch staff members
Future<List<AddStaff>> fetchStaffMembers() async {
  try {
    Response response = await HttpServices().getDioInstance().get(
          baseUrl + getStaff,
        );
    if (response.statusCode == 200) {
      // Parse the response data into a list of AddStaffModel objects
      List<dynamic> data = response.data['staff'];
      List<AddStaff> staffMembers =
          data.map((item) => AddStaff.fromJson(item)).toList();
      return staffMembers;
    } else {
      throw Exception("Failed to fetch staff members: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching staff members: $e");
    throw Exception("Failed to fetch staff members");
  }
}

class AddStaff {
  final String name;
  final String location;
  final String number;

  AddStaff({
    required this.name,
    required this.location,
    required this.number,
  });

  factory AddStaff.fromJson(Map<String, dynamic> json) {
    return AddStaff(
      name: json['name'],
      location: json['location'],
      number: json['phone'],
    );
  }
}
