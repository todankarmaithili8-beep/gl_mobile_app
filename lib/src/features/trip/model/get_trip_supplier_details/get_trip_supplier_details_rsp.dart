import 'package:json_annotation/json_annotation.dart';

part 'get_trip_supplier_details_rsp.g.dart';

@JsonSerializable()
class GetTripSupplierDetailsRsp {
  final String? sTag;
  final String? sExtraInfo;
  final TripSupplierStatus? status;
  final List<TripSupplierDetailModel>? liSupplierTripDetails;

  GetTripSupplierDetailsRsp({
    this.sTag,
    this.sExtraInfo,
    this.status,
    this.liSupplierTripDetails,
  });

  factory GetTripSupplierDetailsRsp.fromJson(Map<String, dynamic> json) =>
      _$GetTripSupplierDetailsRspFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripSupplierDetailsRspToJson(this);
}

@JsonSerializable()
class TripSupplierStatus {
  final int? jStatusCode;
  final String? sResponseText;

  TripSupplierStatus({this.jStatusCode, this.sResponseText});

  factory TripSupplierStatus.fromJson(Map<String, dynamic> json) =>
      _$TripSupplierStatusFromJson(json);

  Map<String, dynamic> toJson() => _$TripSupplierStatusToJson(this);
}

@JsonSerializable()
class TripSupplierDetailModel {
  final String? suidTripSupplierDetails;
  final DateTime? dtArrivalStart;
  final DateTime? dtPickupStart;
  final DateTime? dtDeparture;
  final bool? bPickup;
  final int? jUtilization;
  final String? sLatlong;
  final String? sLocation;
  final String? sSupplierPickupstatus;
  final int? jSupplierPickupstatus;
  final String? sUtilization;
  final String? suidSupplier;
  final String? sSupplierName;
  final DateTime? dtPickupEnd;
  final String? sPickupStartDate;
  final String? sArrivalStartTime;
  final String? sPickupStartTime;
  final String? sDepartureTime;
  final String? sPickupEnd;

  TripSupplierDetailModel({
    this.suidTripSupplierDetails,
    this.dtArrivalStart,
    this.dtPickupStart,
    this.dtDeparture,
    this.bPickup,
    this.jUtilization,
    this.sLatlong,
    this.sLocation,
    this.sSupplierPickupstatus,
    this.jSupplierPickupstatus,
    this.sUtilization,
    this.suidSupplier,
    this.sSupplierName,
    this.dtPickupEnd,
    this.sPickupStartDate,
    this.sArrivalStartTime,
    this.sPickupStartTime,
    this.sDepartureTime,
    this.sPickupEnd,
  });

  factory TripSupplierDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TripSupplierDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripSupplierDetailModelToJson(this);
}
