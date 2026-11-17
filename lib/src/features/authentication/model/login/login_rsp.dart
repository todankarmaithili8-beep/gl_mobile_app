import 'package:json_annotation/json_annotation.dart';

part 'login_rsp.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginRsp {
  final String sTag;
  final String sExtraInfo;
  final LoginStatus? status;
  final String suidSession;
  final LoginUser? objUser;

  LoginRsp({
    this.sTag = '',
    this.sExtraInfo = '',
    this.status,
    this.suidSession = '',
    this.objUser,
  });

  factory LoginRsp.fromJson(Map<String, dynamic> json) =>
      _$LoginRspFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRspToJson(this);
}

@JsonSerializable()
class LoginStatus {
  final int jStatusCode;
  final String sResponseText;

  LoginStatus({this.jStatusCode = -1, this.sResponseText = ''});

  factory LoginStatus.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStatusToJson(this);
}

@JsonSerializable()
class LoginUser {
  final String suid;
  final int jStatus;
  final DateTime? dtCreated;
  final String suidUserCreatedBy;
  final String sUsernameCreatedBy;
  final DateTime? dtUpdated;
  final String suidUserUpdatedBy;
  final String sUsernameUpdatedBy;
  final String sUsername;
  final int jUserRole;
  final String sUserRoleText;

  LoginUser({
    this.suid = '',
    this.jStatus = 0,
    this.dtCreated,
    this.suidUserCreatedBy = '',
    this.sUsernameCreatedBy = '',
    this.dtUpdated,
    this.suidUserUpdatedBy = '',
    this.sUsernameUpdatedBy = '',
    this.sUsername = '',
    this.jUserRole = 0,
    this.sUserRoleText = '',
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}
