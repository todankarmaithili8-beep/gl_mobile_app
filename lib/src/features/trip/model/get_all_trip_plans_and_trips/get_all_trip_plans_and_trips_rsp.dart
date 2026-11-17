import 'package:json_annotation/json_annotation.dart';

part 'get_all_trip_plans_and_trips_rsp.g.dart';

@JsonSerializable()
class GetAllTripPlansAndTripsRsp {
  final String? sTag;
  final String? sExtraInfo;
  final ApiStatus? status;
  final List<TripPlanAndTrip>? data;
  final bool? fPagination;
  final int? jAvailableRecords;
  final int? jPageNumber;
  final Map<String, dynamic>? objAdditionalData;

  GetAllTripPlansAndTripsRsp({
    this.sTag,
    this.sExtraInfo,
    this.status,
    this.data,
    this.fPagination,
    this.jAvailableRecords,
    this.jPageNumber,
    this.objAdditionalData,
  });

  factory GetAllTripPlansAndTripsRsp.fromJson(Map<String, dynamic> json) =>
      _$GetAllTripPlansAndTripsRspFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTripPlansAndTripsRspToJson(this);
}

@JsonSerializable()
class ApiStatus {
  final int? jStatusCode;
  final String? sResponseText;

  ApiStatus({this.jStatusCode, this.sResponseText});

  factory ApiStatus.fromJson(Map<String, dynamic> json) =>
      _$ApiStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ApiStatusToJson(this);
}

@JsonSerializable()
class TripPlanAndTrip {
  final TripPlan? tripPlan;
  final Trip? trip;

  TripPlanAndTrip({this.tripPlan, this.trip});

  factory TripPlanAndTrip.fromJson(Map<String, dynamic> json) =>
      _$TripPlanAndTripFromJson(json);

  Map<String, dynamic> toJson() => _$TripPlanAndTripToJson(this);
}

@JsonSerializable()
class TripPlan {
  final String? suidTripPlan;
  final String? suidDivision;
  final String? uidBuyerFK;
  final DateTime? dtPickup;
  final int? jMovementType;
  final String? sStoreLocation;
  final String? sFromRegion;
  final String? sToRegion;
  final int? jPriority;
  final String? sPayload;
  final num? dWeight;
  final String? sMaterialDescription;
  final String? sDimension;
  final String? sRemark;
  final String? sSpecialRemark;
  final int? jTripStatus;
  final int? jStatus;
  final DateTime? dtCreated;
  final DateTime? dtUpdated;
  final String? suidUser_CreatedBy;
  final String? suidUser_UpdatedBy;
  final String? sDivisionName;
  final String? sBuyerName;
  final String? suidBuyer;
  final String? sMovementType;
  final String? sPriority;
  final String? sDtPickup;
  final String? suidTripType;
  final String? sTripType;

  TripPlan({
    this.suidTripPlan,
    this.suidDivision,
    this.uidBuyerFK,
    this.dtPickup,
    this.jMovementType,
    this.sStoreLocation,
    this.sFromRegion,
    this.sToRegion,
    this.jPriority,
    this.sPayload,
    this.dWeight,
    this.sMaterialDescription,
    this.sDimension,
    this.sRemark,
    this.sSpecialRemark,
    this.jTripStatus,
    this.jStatus,
    this.dtCreated,
    this.dtUpdated,
    this.suidUser_CreatedBy,
    this.suidUser_UpdatedBy,
    this.sDivisionName,
    this.sBuyerName,
    this.suidBuyer,
    this.sMovementType,
    this.sPriority,
    this.sDtPickup,
    this.suidTripType,
    this.sTripType,
  });

  factory TripPlan.fromJson(Map<String, dynamic> json) =>
      _$TripPlanFromJson(json);

  Map<String, dynamic> toJson() => _$TripPlanToJson(this);
}

@JsonSerializable()
class Trip {
  final String? suidTripPlan;
  final String? suidDivision;
  final String? suidVehicle;
  final String? suidDriver;
  final DateTime? dtPickup;
  final DateTime? dtExpectedStartTime;
  final DateTime? dtExpectedEndTime;
  final DateTime? dtActualStart;
  final DateTime? dtActualEnd;
  final int? jStatus;
  final DateTime? dtCreated;
  final DateTime? dtUpdated;
  final String? suidUser_CreatedBy;
  final String? suidUser_UpdatedBy;
  final String? sTripStatus;
  final String? sdtExpectedStartTime;
  final String? sStartedTime;
  final String? suidTrip;
  final String? sdtExpectedEndTime;

  // Vehicle and trip details from API
  final String? sVehicleNumber;
  final String? sDriverName;
  final String? sTripId;
  final String? sActualStartTime;
  final String? sActualEndTime;

  Trip({
    this.suidTripPlan,
    this.suidDivision,
    this.suidVehicle,
    this.suidDriver,
    this.dtPickup,
    this.dtExpectedStartTime,
    this.dtExpectedEndTime,
    this.dtActualStart,
    this.dtActualEnd,
    this.jStatus,
    this.dtCreated,
    this.dtUpdated,
    this.suidUser_CreatedBy,
    this.suidUser_UpdatedBy,
    this.sTripStatus,
    this.sdtExpectedStartTime,
    this.sStartedTime,
    this.suidTrip,
    this.sdtExpectedEndTime,
    this.sVehicleNumber,
    this.sDriverName,
    this.sTripId,
    this.sActualStartTime,
    this.sActualEndTime,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
