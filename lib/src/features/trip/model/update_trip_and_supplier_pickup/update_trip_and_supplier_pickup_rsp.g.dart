// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_trip_and_supplier_pickup_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTripAndSupplierPickupRsp _$UpdateTripAndSupplierPickupRspFromJson(
  Map<String, dynamic> json,
) => UpdateTripAndSupplierPickupRsp(
  sTag: json['sTag'] as String?,
  sExtraInfo: json['sExtraInfo'] as String?,
  status: json['status'] == null
      ? null
      : UpdateTripStatus.fromJson(json['status'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateTripAndSupplierPickupRspToJson(
  UpdateTripAndSupplierPickupRsp instance,
) => <String, dynamic>{
  'sTag': instance.sTag,
  'sExtraInfo': instance.sExtraInfo,
  'status': instance.status,
};

UpdateTripStatus _$UpdateTripStatusFromJson(Map<String, dynamic> json) =>
    UpdateTripStatus(
      jStatusCode: (json['jStatusCode'] as num?)?.toInt(),
      sResponseText: json['sResponseText'] as String?,
    );

Map<String, dynamic> _$UpdateTripStatusToJson(UpdateTripStatus instance) =>
    <String, dynamic>{
      'jStatusCode': instance.jStatusCode,
      'sResponseText': instance.sResponseText,
    };
