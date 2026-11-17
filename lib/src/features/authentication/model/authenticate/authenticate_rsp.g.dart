// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  sTag: json['sTag'] as String? ?? '',
  sExtraInfo: json['sExtraInfo'] as String? ?? '',
  status: json['status'] == null
      ? null
      : AuthStatus.fromJson(json['status'] as Map<String, dynamic>),
  data: json['data'] == null
      ? null
      : AuthData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'sTag': instance.sTag,
      'sExtraInfo': instance.sExtraInfo,
      'status': instance.status?.toJson(),
      'data': instance.data?.toJson(),
    };

AuthStatus _$AuthStatusFromJson(Map<String, dynamic> json) => AuthStatus(
  jStatusCode: (json['jStatusCode'] as num?)?.toInt() ?? -1,
  sResponseText: json['sResponseText'] as String? ?? '',
);

Map<String, dynamic> _$AuthStatusToJson(AuthStatus instance) =>
    <String, dynamic>{
      'jStatusCode': instance.jStatusCode,
      'sResponseText': instance.sResponseText,
    };

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
  suid: json['suid'] as String?,
  jStatus: (json['jStatus'] as num?)?.toInt(),
  dtCreated: json['dtCreated'] == null
      ? null
      : DateTime.parse(json['dtCreated'] as String),
  suidUserCreatedBy: json['suidUserCreatedBy'] as String?,
  sUsernameCreatedBy: json['sUsernameCreatedBy'] as String?,
  dtUpdated: json['dtUpdated'] == null
      ? null
      : DateTime.parse(json['dtUpdated'] as String),
  suidUserUpdatedBy: json['suidUserUpdatedBy'] as String?,
  sUsernameUpdatedBy: json['sUsernameUpdatedBy'] as String?,
  sClientAppID: json['sClientAppID'] as String?,
  sClientAppKey: json['sClientAppKey'] as String?,
  sSalt: json['sSalt'] as String?,
  sAuthToken: json['sAuthToken'] as String?,
);

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
  'suid': instance.suid,
  'jStatus': instance.jStatus,
  'dtCreated': instance.dtCreated?.toIso8601String(),
  'suidUserCreatedBy': instance.suidUserCreatedBy,
  'sUsernameCreatedBy': instance.sUsernameCreatedBy,
  'dtUpdated': instance.dtUpdated?.toIso8601String(),
  'suidUserUpdatedBy': instance.suidUserUpdatedBy,
  'sUsernameUpdatedBy': instance.sUsernameUpdatedBy,
  'sClientAppID': instance.sClientAppID,
  'sClientAppKey': instance.sClientAppKey,
  'sSalt': instance.sSalt,
  'sAuthToken': instance.sAuthToken,
};
