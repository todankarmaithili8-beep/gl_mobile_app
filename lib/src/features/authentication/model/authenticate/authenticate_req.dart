import 'package:json_annotation/json_annotation.dart';

part 'authenticate_req.g.dart';

@JsonSerializable()
class AuthenticateReq {
  final String sAuthKey;

  AuthenticateReq({required this.sAuthKey});

  factory AuthenticateReq.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateReqFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateReqToJson(this);
}
