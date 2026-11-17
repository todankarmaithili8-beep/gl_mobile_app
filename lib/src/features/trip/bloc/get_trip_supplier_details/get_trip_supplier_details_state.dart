import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_req.dart';
import 'package:equatable/equatable.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_rsp.dart';

abstract class GetTripSupplierDetailsState extends Equatable {
  const GetTripSupplierDetailsState();

  @override
  List<Object?> get props => [];
}

class GetTripSupplierDetailsInitial extends GetTripSupplierDetailsState {}

class GetTripSupplierDetailsLoading extends GetTripSupplierDetailsState {}

class GetTripSupplierDetailsSuccess extends GetTripSupplierDetailsState {
  final GetTripSupplierDetailsRsp response;
  final List<TripSupplierDetailModel> supplierDetails;

  const GetTripSupplierDetailsSuccess({
    required this.response,
    required this.supplierDetails,
  });

  @override
  List<Object?> get props => [response, supplierDetails];
}

class GetTripSupplierDetailsFailure extends GetTripSupplierDetailsState {
  final String message;

  const GetTripSupplierDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
