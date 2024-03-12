// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addStaffModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddStaffModelImpl _$$AddStaffModelImplFromJson(Map<String, dynamic> json) =>
    _$AddStaffModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      location: json['location'] as String,
      house: json['house'] as int?,
      ward: json['ward'] as int?,
      role: json['role'] as String?,
      isAdmin: json['isAdmin'] as int?,
      isStaff: json['isStaff'] as int?,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$AddStaffModelImplToJson(_$AddStaffModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'location': instance.location,
      'house': instance.house,
      'ward': instance.ward,
      'role': instance.role,
      'isAdmin': instance.isAdmin,
      'isStaff': instance.isStaff,
      'phone': instance.phone,
    };
