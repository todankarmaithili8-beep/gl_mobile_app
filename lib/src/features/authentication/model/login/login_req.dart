import 'package:json_annotation/json_annotation.dart';

part 'login_req.g.dart';

@JsonSerializable()
class LoginReq {
  final String sTag;
  final String sTimeZone;
  final String sUsername;
  final String sPasswordHash;

  LoginReq({
    this.sTag = '',
    this.sTimeZone = '',
    required this.sUsername,
    required this.sPasswordHash,
  });

  factory LoginReq.fromJson(Map<String, dynamic> json) =>
      _$LoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReqToJson(this);
}
