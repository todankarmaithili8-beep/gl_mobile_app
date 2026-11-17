// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_trip_plans_and_trips_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTripPlansAndTripsRsp _$GetAllTripPlansAndTripsRspFromJson(
  Map<String, dynamic> json,
) => GetAllTripPlansAndTripsRsp(
  sTag: json['sTag'] as String?,
  sExtraInfo: json['sExtraInfo'] as String?,
  status: json['status'] == null
      ? null
      : ApiStatus.fromJson(json['status'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => TripPlanAndTrip.fromJson(e as Map<String, dynamic>))
      .toList(),
  fPagination: json['fPagination'] as bool?,
  jAvailableRecords: (json['jAvailableRecords'] as num?)?.toInt(),
  jPageNumber: (json['jPageNumber'] as num?)?.toInt(),
  objAdditionalData: json['objAdditionalData'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$GetAllTripPlansAndTripsRspToJson(
  GetAllTripPlansAndTripsRsp instance,
) => <String, dynamic>{
  'sTag': instance.sTag,
  'sExtraInfo': instance.sExtraInfo,
  'status': instance.status,
  'data': instance.data,
  'fPagination': instance.fPagination,
  'jAvailableRecords': instance.jAvailableRecords,
  'jPageNumber': instance.jPageNumber,
  'objAdditionalData': instance.objAdditionalData,
};

ApiStatus _$ApiStatusFromJson(Map<String, dynamic> json) => ApiStatus(
  jStatusCode: (json['jStatusCode'] as num?)?.toInt(),
  sResponseText: json['sResponseText'] as String?,
);

Map<String, dynamic> _$ApiStatusToJson(ApiStatus instance) => <String, dynamic>{
  'jStatusCode': instance.jStatusCode,
  'sResponseText': instance.sResponseText,
};

TripPlanAndTrip _$TripPlanAndTripFromJson(Map<String, dynamic> json) =>
    TripPlanAndTrip(
      tripPlan: json['tripPlan'] == null
          ? null
          : TripPlan.fromJson(json['tripPlan'] as Map<String, dynamic>),
      trip: json['trip'] == null
          ? null
          : Trip.fromJson(json['trip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripPlanAndTripToJson(TripPlanAndTrip instance) =>
    <String, dynamic>{'tripPlan': instance.tripPlan, 'trip': instance.trip};

TripPlan _$TripPlanFromJson(Map<String, dynamic> json) => TripPlan(
  suidTripPlan: json['suidTripPlan'] as String?,
  suidDivision: json['suidDivision'] as String?,
  uidBuyerFK: json['uidBuyerFK'] as String?,
  dtPickup: json['dtPickup'] == null
      ? null
      : DateTime.parse(json['dtPickup'] as String),
  jMovementType: (json['jMovementType'] as num?)?.toInt(),
  sStoreLocation: json['sStoreLocation'] as String?,
  sFromRegion: json['sFromRegion'] as String?,
  sToRegion: json['sToRegion'] as String?,
  jPriority: (json['jPriority'] as num?)?.toInt(),
  sPayload: json['sPayload'] as String?,
  dWeight: json['dWeight'] as num?,
  sMaterialDescription: json['sMaterialDescription'] as String?,
  sDimension: json['sDimension'] as String?,
  sRemark: json['sRemark'] as String?,
  sSpecialRemark: json['sSpecialRemark'] as String?,
  jTripStatus: (json['jTripStatus'] as num?)?.toInt(),
  jStatus: (json['jStatus'] as num?)?.toInt(),
  dtCreated: json['dtCreated'] == null
      ? null
      : DateTime.parse(json['dtCreated'] as String),
  dtUpdated: json['dtUpdated'] == null
      ? null
      : DateTime.parse(json['dtUpdated'] as String),
  suidUser_CreatedBy: json['suidUser_CreatedBy'] as String?,
  suidUser_UpdatedBy: json['suidUser_UpdatedBy'] as String?,
  sDivisionName: json['sDivisionName'] as String?,
  sBuyerName: json['sBuyerName'] as String?,
  suidBuyer: json['suidBuyer'] as String?,
  sMovementType: json['sMovementType'] as String?,
  sPriority: json['sPriority'] as String?,
  sDtPickup: json['sDtPickup'] as String?,
  suidTripType: json['suidTripType'] as String?,
  sTripType: json['sTripType'] as String?,
);

Map<String, dynamic> _$TripPlanToJson(TripPlan instance) => <String, dynamic>{
  'suidTripPlan': instance.suidTripPlan,
  'suidDivision': instance.suidDivision,
  'uidBuyerFK': instance.uidBuyerFK,
  'dtPickup': instance.dtPickup?.toIso8601String(),
  'jMovementType': instance.jMovementType,
  'sStoreLocation': instance.sStoreLocation,
  'sFromRegion': instance.sFromRegion,
  'sToRegion': instance.sToRegion,
  'jPriority': instance.jPriority,
  'sPayload': instance.sPayload,
  'dWeight': instance.dWeight,
  'sMaterialDescription': instance.sMaterialDescription,
  'sDimension': instance.sDimension,
  'sRemark': instance.sRemark,
  'sSpecialRemark': instance.sSpecialRemark,
  'jTripStatus': instance.jTripStatus,
  'jStatus': instance.jStatus,
  'dtCreated': instance.dtCreated?.toIso8601String(),
  'dtUpdated': instance.dtUpdated?.toIso8601String(),
  'suidUser_CreatedBy': instance.suidUser_CreatedBy,
  'suidUser_UpdatedBy': instance.suidUser_UpdatedBy,
  'sDivisionName': instance.sDivisionName,
  'sBuyerName': instance.sBuyerName,
  'suidBuyer': instance.suidBuyer,
  'sMovementType': instance.sMovementType,
  'sPriority': instance.sPriority,
  'sDtPickup': instance.sDtPickup,
  'suidTripType': instance.suidTripType,
  'sTripType': instance.sTripType,
};

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
  suidTripPlan: json['suidTripPlan'] as String?,
  suidDivision: json['suidDivision'] as String?,
  suidVehicle: json['suidVehicle'] as String?,
  suidDriver: json['suidDriver'] as String?,
  dtPickup: json['dtPickup'] == null
      ? null
      : DateTime.parse(json['dtPickup'] as String),
  dtExpectedStartTime: json['dtExpectedStartTime'] == null
      ? null
      : DateTime.parse(json['dtExpectedStartTime'] as String),
  dtExpectedEndTime: json['dtExpectedEndTime'] == null
      ? null
      : DateTime.parse(json['dtExpectedEndTime'] as String),
  dtActualStart: json['dtActualStart'] == null
      ? null
      : DateTime.parse(json['dtActualStart'] as String),
  dtActualEnd: json['dtActualEnd'] == null
      ? null
      : DateTime.parse(json['dtActualEnd'] as String),
  jStatus: (json['jStatus'] as num?)?.toInt(),
  dtCreated: json['dtCreated'] == null
      ? null
      : DateTime.parse(json['dtCreated'] as String),
  dtUpdated: json['dtUpdated'] == null
      ? null
      : DateTime.parse(json['dtUpdated'] as String),
  suidUser_CreatedBy: json['suidUser_CreatedBy'] as String?,
  suidUser_UpdatedBy: json['suidUser_UpdatedBy'] as String?,
  sTripStatus: json['sTripStatus'] as String?,
  sdtExpectedStartTime: json['sdtExpectedStartTime'] as String?,
  sStartedTime: json['sStartedTime'] as String?,
  suidTrip: json['suidTrip'] as String?,
  sdtExpectedEndTime: json['sdtExpectedEndTime'] as String?,
  sVehicleNumber: json['sVehicleNumber'] as String?,
  sDriverName: json['sDriverName'] as String?,
  sTripId: json['sTripId'] as String?,
  sActualStartTime: json['sActualStartTime'] as String?,
  sActualEndTime: json['sActualEndTime'] as String?,
);

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
  'suidTripPlan': instance.suidTripPlan,
  'suidDivision': instance.suidDivision,
  'suidVehicle': instance.suidVehicle,
  'suidDriver': instance.suidDriver,
  'dtPickup': instance.dtPickup?.toIso8601String(),
  'dtExpectedStartTime': instance.dtExpectedStartTime?.toIso8601String(),
  'dtExpectedEndTime': instance.dtExpectedEndTime?.toIso8601String(),
  'dtActualStart': instance.dtActualStart?.toIso8601String(),
  'dtActualEnd': instance.dtActualEnd?.toIso8601String(),
  'jStatus': instance.jStatus,
  'dtCreated': instance.dtCreated?.toIso8601String(),
  'dtUpdated': instance.dtUpdated?.toIso8601String(),
  'suidUser_CreatedBy': instance.suidUser_CreatedBy,
  'suidUser_UpdatedBy': instance.suidUser_UpdatedBy,
  'sTripStatus': instance.sTripStatus,
  'sdtExpectedStartTime': instance.sdtExpectedStartTime,
  'sStartedTime': instance.sStartedTime,
  'suidTrip': instance.suidTrip,
  'sdtExpectedEndTime': instance.sdtExpectedEndTime,
  'sVehicleNumber': instance.sVehicleNumber,
  'sDriverName': instance.sDriverName,
  'sTripId': instance.sTripId,
  'sActualStartTime': instance.sActualStartTime,
  'sActualEndTime': instance.sActualEndTime,
};
