import 'package:json_annotation/json_annotation.dart';
part 'authenticate_rsp.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  final String sTag;
  final String sExtraInfo;
  final AuthStatus? status;
  final AuthData? data;

  AuthResponse({this.sTag = '', this.sExtraInfo = '', this.status, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthStatus {
  final int jStatusCode;
  final String sResponseText;

  AuthStatus({this.jStatusCode = -1, this.sResponseText = ''});

  factory AuthStatus.fromJson(Map<String, dynamic> json) =>
      _$AuthStatusFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStatusToJson(this);
}

@JsonSerializable()
class AuthData {
  final String? suid;
  final int? jStatus;
  final DateTime? dtCreated;
  final String? suidUserCreatedBy;
  final String? sUsernameCreatedBy;
  final DateTime? dtUpdated;
  final String? suidUserUpdatedBy;
  final String? sUsernameUpdatedBy;
  final String? sClientAppID;
  final String? sClientAppKey;
  final String? sSalt;
  final String? sAuthToken;

  AuthData({
    this.suid,
    this.jStatus,
    this.dtCreated,
    this.suidUserCreatedBy,
    this.sUsernameCreatedBy,
    this.dtUpdated,
    this.suidUserUpdatedBy,
    this.sUsernameUpdatedBy,
    this.sClientAppID,
    this.sClientAppKey,
    this.sSalt,
    this.sAuthToken,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
