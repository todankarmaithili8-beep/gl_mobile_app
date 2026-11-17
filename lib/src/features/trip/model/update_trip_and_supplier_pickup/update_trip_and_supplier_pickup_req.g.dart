// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_trip_and_supplier_pickup_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTripAndSupplierPickupReq _$UpdateTripAndSupplierPickupReqFromJson(
  Map<String, dynamic> json,
) => UpdateTripAndSupplierPickupReq(
  sTag: json['sTag'] as String,
  sTimeZone: json['sTimeZone'] as String,
  suidSession: json['suidSession'] as String,
  jTripAction: (json['jTripAction'] as num).toInt(),
  suidTrip: json['suidTrip'] as String,
  dtActualStart: json['dtActualStart'] as String?,
  dtActualEnd: json['dtActualEnd'] as String?,
  suidTripSupplierDetails: json['suidTripSupplierDetails'] as String?,
  dtArrivalStart: json['dtArrivalStart'] as String?,
  dtPickupStart: json['dtPickupStart'] as String?,
  dtDeparture: json['dtDeparture'] as String?,
  dtPickupEnd: json['dtPickupEnd'] as String?,
  sArrivalStartLatlong: json['sArrivalStartLatlong'] as String?,
  sDepartureLatlong: json['sDepartureLatlong'] as String?,
  sLocation: json['sLocation'] as String?,
);

Map<String, dynamic> _$UpdateTripAndSupplierPickupReqToJson(
  UpdateTripAndSupplierPickupReq instance,
) => <String, dynamic>{
  'sTag': instance.sTag,
  'sTimeZone': instance.sTimeZone,
  'suidSession': instance.suidSession,
  'jTripAction': instance.jTripAction,
  'suidTrip': instance.suidTrip,
  'dtActualStart': instance.dtActualStart,
  'dtActualEnd': instance.dtActualEnd,
  'suidTripSupplierDetails': instance.suidTripSupplierDetails,
  'dtArrivalStart': instance.dtArrivalStart,
  'dtPickupStart': instance.dtPickupStart,
  'dtDeparture': instance.dtDeparture,
  'dtPickupEnd': instance.dtPickupEnd,
  'sArrivalStartLatlong': instance.sArrivalStartLatlong,
  'sDepartureLatlong': instance.sDepartureLatlong,
  'sLocation': instance.sLocation,
};
