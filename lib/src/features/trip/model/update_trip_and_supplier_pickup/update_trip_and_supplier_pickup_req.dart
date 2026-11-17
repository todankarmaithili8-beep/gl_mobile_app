import 'package:json_annotation/json_annotation.dart';

part 'update_trip_and_supplier_pickup_req.g.dart';

@JsonSerializable()
class UpdateTripAndSupplierPickupReq {
  final String sTag;
  final String sTimeZone;
  final String suidSession;
  final int jTripAction;
  final String suidTrip;
  final String? dtActualStart;
  final String? dtActualEnd;
  final String? suidTripSupplierDetails;
  final String? dtArrivalStart;
  final String? dtPickupStart;
  final String? dtDeparture;
  final String? dtPickupEnd;
  final String? sArrivalStartLatlong;
  final String? sDepartureLatlong;
  final String? sLocation;

  const UpdateTripAndSupplierPickupReq({
    required this.sTag,
    required this.sTimeZone,
    required this.suidSession,
    required this.jTripAction,
    required this.suidTrip,
    this.dtActualStart,
    this.dtActualEnd,
    this.suidTripSupplierDetails,
    this.dtArrivalStart,
    this.dtPickupStart,
    this.dtDeparture,
    this.dtPickupEnd,
    this.sArrivalStartLatlong,
    this.sDepartureLatlong,
    this.sLocation,
  });

  factory UpdateTripAndSupplierPickupReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateTripAndSupplierPickupReqFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTripAndSupplierPickupReqToJson(this);
}
