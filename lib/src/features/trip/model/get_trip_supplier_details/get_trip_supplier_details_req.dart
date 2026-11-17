import 'package:json_annotation/json_annotation.dart';

part 'get_trip_supplier_details_req.g.dart';

@JsonSerializable()
class GetTripSupplierDetailsReq {
  final String sTag;
  final String sTimeZone;
  final String suidSession;
  final String suidTrip;

  GetTripSupplierDetailsReq({
    required this.sTag,
    required this.sTimeZone,
    required this.suidSession,
    required this.suidTrip,
  });

  factory GetTripSupplierDetailsReq.fromJson(Map<String, dynamic> json) =>
      _$GetTripSupplierDetailsReqFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripSupplierDetailsReqToJson(this);
}
