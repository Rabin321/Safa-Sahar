import 'package:finalyear/domain/addStaff/addStaffApi/addStaffApi.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/signup/signupApi/signupApi.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';

class StaffRepository {
  Future<bool> register(AddStaffModel user) async {
    return await AddStaffApi().register(user);
  }
}
