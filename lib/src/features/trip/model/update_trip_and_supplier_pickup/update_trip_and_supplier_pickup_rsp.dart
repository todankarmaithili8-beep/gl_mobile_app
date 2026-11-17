import 'package:json_annotation/json_annotation.dart';

part 'update_trip_and_supplier_pickup_rsp.g.dart';

@JsonSerializable()
class UpdateTripAndSupplierPickupRsp {
  final String? sTag;
  final String? sExtraInfo;
  final UpdateTripStatus? status;

  const UpdateTripAndSupplierPickupRsp({
    this.sTag,
    this.sExtraInfo,
    this.status,
  });

  factory UpdateTripAndSupplierPickupRsp.fromJson(Map<String, dynamic> json) =>
      _$UpdateTripAndSupplierPickupRspFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTripAndSupplierPickupRspToJson(this);
}

@JsonSerializable()
class UpdateTripStatus {
  final int? jStatusCode;
  final String? sResponseText;

  const UpdateTripStatus({this.jStatusCode, this.sResponseText});

  factory UpdateTripStatus.fromJson(Map<String, dynamic> json) =>
      _$UpdateTripStatusFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTripStatusToJson(this);
}
