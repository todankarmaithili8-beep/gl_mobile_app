import 'package:equatable/equatable.dart';

import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_rsp.dart';

abstract class UpdateTripAndSupplierPickupState extends Equatable {
  const UpdateTripAndSupplierPickupState();

  @override
  List<Object?> get props => [];
}

class UpdateTripAndSupplierPickupInitial
    extends UpdateTripAndSupplierPickupState {
  const UpdateTripAndSupplierPickupInitial();
}

class UpdateTripAndSupplierPickupLoading
    extends UpdateTripAndSupplierPickupState {
  const UpdateTripAndSupplierPickupLoading();
}

class UpdateTripAndSupplierPickupSuccess
    extends UpdateTripAndSupplierPickupState {
  final UpdateTripAndSupplierPickupRsp response;

  const UpdateTripAndSupplierPickupSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateTripAndSupplierPickupFailure
    extends UpdateTripAndSupplierPickupState {
  final String message;

  const UpdateTripAndSupplierPickupFailure(this.message);

  @override
  List<Object?> get props => [message];
}
