import 'package:dio/dio.dart';
import 'package:finalyear/domain/addStaff/addStaffApi/addStaffApi.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/domain/signup/signupApi/signupApi.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/model/contents.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/material.dart';

class StaffRepository {
  Future<bool> register(AddStaffModel user) async {
    return await AddStaffApi().register(user);
  }

  Future<List<AddStaff>> fetchStaffMembers(
      {int page = 1, int pageSize = 10}) async {
    try {
      Response response = await HttpServices().getDioInstance().get(
        baseUrl + getStaff,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
      );
      if (response.statusCode == 200) {
        // Parse the response data into a list of AddStaffModel objects
        List<dynamic> data = response.data['staffMembers'];
        List<AddStaff> staffMembers =
            data.map((item) => AddStaff.fromJson(item)).toList();
        return staffMembers;
      } else {
        throw Exception(
            "Failed to fetch staff members: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching staff members: $e");
      throw Exception("Failed to fetch staff members");
    }
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
