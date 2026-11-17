// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_library_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLibraryRsp _$GetLibraryRspFromJson(Map<String, dynamic> json) =>
    GetLibraryRsp(
      sTag: json['sTag'] as String?,
      sExtraInfo: json['sExtraInfo'] as String?,
      status: json['status'] == null
          ? null
          : GetLibraryStatus.fromJson(json['status'] as Map<String, dynamic>),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$GetLibraryRspToJson(GetLibraryRsp instance) =>
    <String, dynamic>{
      'sTag': instance.sTag,
      'sExtraInfo': instance.sExtraInfo,
      'status': instance.status,
      'data': instance.data,
    };

GetLibraryStatus _$GetLibraryStatusFromJson(Map<String, dynamic> json) =>
    GetLibraryStatus(
      jStatusCode: (json['jStatusCode'] as num?)?.toInt(),
      sResponseText: json['sResponseText'] as String?,
    );

Map<String, dynamic> _$GetLibraryStatusToJson(GetLibraryStatus instance) =>
    <String, dynamic>{
      'jStatusCode': instance.jStatusCode,
      'sResponseText': instance.sResponseText,
    };
