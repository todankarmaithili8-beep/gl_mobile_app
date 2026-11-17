// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trip_supplier_details_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripSupplierDetailsReq _$GetTripSupplierDetailsReqFromJson(
  Map<String, dynamic> json,
) => GetTripSupplierDetailsReq(
  sTag: json['sTag'] as String,
  sTimeZone: json['sTimeZone'] as String,
  suidSession: json['suidSession'] as String,
  suidTrip: json['suidTrip'] as String,
);

Map<String, dynamic> _$GetTripSupplierDetailsReqToJson(
  GetTripSupplierDetailsReq instance,
) => <String, dynamic>{
  'sTag': instance.sTag,
  'sTimeZone': instance.sTimeZone,
  'suidSession': instance.suidSession,
  'suidTrip': instance.suidTrip,
};
