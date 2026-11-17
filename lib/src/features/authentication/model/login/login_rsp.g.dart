// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRsp _$LoginRspFromJson(Map<String, dynamic> json) => LoginRsp(
  sTag: json['sTag'] as String? ?? '',
  sExtraInfo: json['sExtraInfo'] as String? ?? '',
  status: json['status'] == null
      ? null
      : LoginStatus.fromJson(json['status'] as Map<String, dynamic>),
  suidSession: json['suidSession'] as String? ?? '',
  objUser: json['objUser'] == null
      ? null
      : LoginUser.fromJson(json['objUser'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginRspToJson(LoginRsp instance) => <String, dynamic>{
  'sTag': instance.sTag,
  'sExtraInfo': instance.sExtraInfo,
  'status': instance.status?.toJson(),
  'suidSession': instance.suidSession,
  'objUser': instance.objUser?.toJson(),
};

LoginStatus _$LoginStatusFromJson(Map<String, dynamic> json) => LoginStatus(
  jStatusCode: (json['jStatusCode'] as num?)?.toInt() ?? -1,
  sResponseText: json['sResponseText'] as String? ?? '',
);

Map<String, dynamic> _$LoginStatusToJson(LoginStatus instance) =>
    <String, dynamic>{
      'jStatusCode': instance.jStatusCode,
      'sResponseText': instance.sResponseText,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
  suid: json['suid'] as String? ?? '',
  jStatus: (json['jStatus'] as num?)?.toInt() ?? 0,
  dtCreated: json['dtCreated'] == null
      ? null
      : DateTime.parse(json['dtCreated'] as String),
  suidUserCreatedBy: json['suidUserCreatedBy'] as String? ?? '',
  sUsernameCreatedBy: json['sUsernameCreatedBy'] as String? ?? '',
  dtUpdated: json['dtUpdated'] == null
      ? null
      : DateTime.parse(json['dtUpdated'] as String),
  suidUserUpdatedBy: json['suidUserUpdatedBy'] as String? ?? '',
  sUsernameUpdatedBy: json['sUsernameUpdatedBy'] as String? ?? '',
  sUsername: json['sUsername'] as String? ?? '',
  jUserRole: (json['jUserRole'] as num?)?.toInt() ?? 0,
  sUserRoleText: json['sUserRoleText'] as String? ?? '',
);

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
  'suid': instance.suid,
  'jStatus': instance.jStatus,
  'dtCreated': instance.dtCreated?.toIso8601String(),
  'suidUserCreatedBy': instance.suidUserCreatedBy,
  'sUsernameCreatedBy': instance.sUsernameCreatedBy,
  'dtUpdated': instance.dtUpdated?.toIso8601String(),
  'suidUserUpdatedBy': instance.suidUserUpdatedBy,
  'sUsernameUpdatedBy': instance.sUsernameUpdatedBy,
  'sUsername': instance.sUsername,
  'jUserRole': instance.jUserRole,
  'sUserRoleText': instance.sUserRoleText,
};
