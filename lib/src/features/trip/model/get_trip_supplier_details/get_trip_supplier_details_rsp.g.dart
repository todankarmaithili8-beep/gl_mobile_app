// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trip_supplier_details_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripSupplierDetailsRsp _$GetTripSupplierDetailsRspFromJson(
  Map<String, dynamic> json,
) => GetTripSupplierDetailsRsp(
  sTag: json['sTag'] as String?,
  sExtraInfo: json['sExtraInfo'] as String?,
  status: json['status'] == null
      ? null
      : TripSupplierStatus.fromJson(json['status'] as Map<String, dynamic>),
  liSupplierTripDetails: (json['liSupplierTripDetails'] as List<dynamic>?)
      ?.map((e) => TripSupplierDetailModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetTripSupplierDetailsRspToJson(
  GetTripSupplierDetailsRsp instance,
) => <String, dynamic>{
  'sTag': instance.sTag,
  'sExtraInfo': instance.sExtraInfo,
  'status': instance.status,
  'liSupplierTripDetails': instance.liSupplierTripDetails,
};

TripSupplierStatus _$TripSupplierStatusFromJson(Map<String, dynamic> json) =>
    TripSupplierStatus(
      jStatusCode: (json['jStatusCode'] as num?)?.toInt(),
      sResponseText: json['sResponseText'] as String?,
    );

Map<String, dynamic> _$TripSupplierStatusToJson(TripSupplierStatus instance) =>
    <String, dynamic>{
      'jStatusCode': instance.jStatusCode,
      'sResponseText': instance.sResponseText,
    };

TripSupplierDetailModel _$TripSupplierDetailModelFromJson(
  Map<String, dynamic> json,
) => TripSupplierDetailModel(
  suidTripSupplierDetails: json['suidTripSupplierDetails'] as String?,
  dtArrivalStart: json['dtArrivalStart'] == null
      ? null
      : DateTime.parse(json['dtArrivalStart'] as String),
  dtPickupStart: json['dtPickupStart'] == null
      ? null
      : DateTime.parse(json['dtPickupStart'] as String),
  dtDeparture: json['dtDeparture'] == null
      ? null
      : DateTime.parse(json['dtDeparture'] as String),
  bPickup: json['bPickup'] as bool?,
  jUtilization: (json['jUtilization'] as num?)?.toInt(),
  sLatlong: json['sLatlong'] as String?,
  sLocation: json['sLocation'] as String?,
  sSupplierPickupstatus: json['sSupplierPickupstatus'] as String?,
  jSupplierPickupstatus: (json['jSupplierPickupstatus'] as num?)?.toInt(),
  sUtilization: json['sUtilization'] as String?,
  suidSupplier: json['suidSupplier'] as String?,
  sSupplierName: json['sSupplierName'] as String?,
  dtPickupEnd: json['dtPickupEnd'] == null
      ? null
      : DateTime.parse(json['dtPickupEnd'] as String),
  sPickupStartDate: json['sPickupStartDate'] as String?,
  sArrivalStartTime: json['sArrivalStartTime'] as String?,
  sPickupStartTime: json['sPickupStartTime'] as String?,
  sDepartureTime: json['sDepartureTime'] as String?,
  sPickupEnd: json['sPickupEnd'] as String?,
);

Map<String, dynamic> _$TripSupplierDetailModelToJson(
  TripSupplierDetailModel instance,
) => <String, dynamic>{
  'suidTripSupplierDetails': instance.suidTripSupplierDetails,
  'dtArrivalStart': instance.dtArrivalStart?.toIso8601String(),
  'dtPickupStart': instance.dtPickupStart?.toIso8601String(),
  'dtDeparture': instance.dtDeparture?.toIso8601String(),
  'bPickup': instance.bPickup,
  'jUtilization': instance.jUtilization,
  'sLatlong': instance.sLatlong,
  'sLocation': instance.sLocation,
  'sSupplierPickupstatus': instance.sSupplierPickupstatus,
  'jSupplierPickupstatus': instance.jSupplierPickupstatus,
  'sUtilization': instance.sUtilization,
  'suidSupplier': instance.suidSupplier,
  'sSupplierName': instance.sSupplierName,
  'dtPickupEnd': instance.dtPickupEnd?.toIso8601String(),
  'sPickupStartDate': instance.sPickupStartDate,
  'sArrivalStartTime': instance.sArrivalStartTime,
  'sPickupStartTime': instance.sPickupStartTime,
  'sDepartureTime': instance.sDepartureTime,
  'sPickupEnd': instance.sPickupEnd,
};
