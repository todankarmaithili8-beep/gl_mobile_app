import 'package:json_annotation/json_annotation.dart';

part 'get_library_req.g.dart';

@JsonSerializable()
class GetLibraryReq {
  final String sTag;
  final String sTimeZone;
  final String suidSession;

  const GetLibraryReq({
    required this.sTag,
    required this.sTimeZone,
    required this.suidSession,
  });

  factory GetLibraryReq.fromJson(Map<String, dynamic> json) =>
      _$GetLibraryReqFromJson(json);

  Map<String, dynamic> toJson() => _$GetLibraryReqToJson(this);
}
