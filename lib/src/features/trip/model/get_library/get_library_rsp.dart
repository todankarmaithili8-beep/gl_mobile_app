import 'package:json_annotation/json_annotation.dart';

part 'get_library_rsp.g.dart';

@JsonSerializable()
class GetLibraryRsp {
  final String? sTag;
  final String? sExtraInfo;
  final GetLibraryStatus? status;
  final String? data;

  const GetLibraryRsp({this.sTag, this.sExtraInfo, this.status, this.data});

  factory GetLibraryRsp.fromJson(Map<String, dynamic> json) =>
      _$GetLibraryRspFromJson(json);

  Map<String, dynamic> toJson() => _$GetLibraryRspToJson(this);
}

@JsonSerializable()
class GetLibraryStatus {
  final int? jStatusCode;
  final String? sResponseText;

  const GetLibraryStatus({this.jStatusCode, this.sResponseText});

  factory GetLibraryStatus.fromJson(Map<String, dynamic> json) =>
      _$GetLibraryStatusFromJson(json);

  Map<String, dynamic> toJson() => _$GetLibraryStatusToJson(this);
}
