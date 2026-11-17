import 'package:equatable/equatable.dart';

abstract class GetTripSupplierDetailsEvent extends Equatable {
  const GetTripSupplierDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTripSupplierDetails extends GetTripSupplierDetailsEvent {
  final String suidTrip;

  const FetchTripSupplierDetails({required this.suidTrip});

  @override
  List<Object?> get props => [suidTrip];
}
