// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReq _$LoginReqFromJson(Map<String, dynamic> json) => LoginReq(
  sTag: json['sTag'] as String? ?? '',
  sTimeZone: json['sTimeZone'] as String? ?? '',
  sUsername: json['sUsername'] as String,
  sPasswordHash: json['sPasswordHash'] as String,
);

Map<String, dynamic> _$LoginReqToJson(LoginReq instance) => <String, dynamic>{
  'sTag': instance.sTag,
  'sTimeZone': instance.sTimeZone,
  'sUsername': instance.sUsername,
  'sPasswordHash': instance.sPasswordHash,
};
