import 'package:json_annotation/json_annotation.dart';

part 'get_all_trip_plans_and_trips_req.g.dart';

@JsonSerializable()
class GetAllTripPlansAndTripsReq {
  final bool? fPagination;
  final String? sFilter;
  final int? jPageNumber;
  final int? jCount;
  final String? sSorting;
  final bool? fWithOutDispatched;
  final String suidSession;
  final String? sTag;
  final String? sTimeZone;

  const GetAllTripPlansAndTripsReq({
    this.fPagination,
    this.sFilter,
    this.jPageNumber,
    this.jCount,
    this.sSorting,
    this.fWithOutDispatched,
    required this.suidSession,
    this.sTag,
    this.sTimeZone,
  });

  factory GetAllTripPlansAndTripsReq.fromJson(Map<String, dynamic> json) =>
      _$GetAllTripPlansAndTripsReqFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTripPlansAndTripsReqToJson(this);
}
