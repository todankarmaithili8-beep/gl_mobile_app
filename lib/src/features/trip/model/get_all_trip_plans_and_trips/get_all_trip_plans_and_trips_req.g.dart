// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_trip_plans_and_trips_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTripPlansAndTripsReq _$GetAllTripPlansAndTripsReqFromJson(
  Map<String, dynamic> json,
) => GetAllTripPlansAndTripsReq(
  fPagination: json['fPagination'] as bool?,
  sFilter: json['sFilter'] as String?,
  jPageNumber: (json['jPageNumber'] as num?)?.toInt(),
  jCount: (json['jCount'] as num?)?.toInt(),
  sSorting: json['sSorting'] as String?,
  fWithOutDispatched: json['fWithOutDispatched'] as bool?,
  suidSession: json['suidSession'] as String,
  sTag: json['sTag'] as String?,
  sTimeZone: json['sTimeZone'] as String?,
);

Map<String, dynamic> _$GetAllTripPlansAndTripsReqToJson(
  GetAllTripPlansAndTripsReq instance,
) => <String, dynamic>{
  'fPagination': instance.fPagination,
  'sFilter': instance.sFilter,
  'jPageNumber': instance.jPageNumber,
  'jCount': instance.jCount,
  'sSorting': instance.sSorting,
  'fWithOutDispatched': instance.fWithOutDispatched,
  'suidSession': instance.suidSession,
  'sTag': instance.sTag,
  'sTimeZone': instance.sTimeZone,
};
