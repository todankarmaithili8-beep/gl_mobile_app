import 'package:equatable/equatable.dart';

import 'package:gl_mobile_app/src/features/trip/model/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_rsp.dart';

abstract class GetAllTripPlansAndTripsState extends Equatable {
  const GetAllTripPlansAndTripsState();

  @override
  List<Object?> get props => [];
}

class GetAllTripPlansAndTripsInitial extends GetAllTripPlansAndTripsState {
  const GetAllTripPlansAndTripsInitial();
}

class GetAllTripPlansAndTripsLoading extends GetAllTripPlansAndTripsState {
  const GetAllTripPlansAndTripsLoading();
}

class GetAllTripPlansAndTripsSuccess extends GetAllTripPlansAndTripsState {
  final GetAllTripPlansAndTripsRsp response;

  const GetAllTripPlansAndTripsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetAllTripPlansAndTripsFailure extends GetAllTripPlansAndTripsState {
  final String message;

  const GetAllTripPlansAndTripsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
