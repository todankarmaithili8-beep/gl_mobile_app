import 'package:equatable/equatable.dart';

abstract class GetAllTripPlansAndTripsEvent extends Equatable {
  const GetAllTripPlansAndTripsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllTripPlansAndTripsRequested extends GetAllTripPlansAndTripsEvent {
  final String suidSession;

  const GetAllTripPlansAndTripsRequested({required this.suidSession});

  @override
  List<Object?> get props => [suidSession];
}
