import 'package:equatable/equatable.dart';

import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_req.dart';

abstract class UpdateTripAndSupplierPickupEvent extends Equatable {
  const UpdateTripAndSupplierPickupEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTripAndSupplierPickupRequested
    extends UpdateTripAndSupplierPickupEvent {
  final UpdateTripAndSupplierPickupReq request;

  const UpdateTripAndSupplierPickupRequested({required this.request});

  @override
  List<Object?> get props => [request];
}
