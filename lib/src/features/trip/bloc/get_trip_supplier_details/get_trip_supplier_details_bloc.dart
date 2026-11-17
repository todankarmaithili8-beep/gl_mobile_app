import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_rsp.dart';

import 'get_trip_supplier_details_event.dart';
import 'get_trip_supplier_details_state.dart';

class GetTripSupplierDetailsBloc
    extends Bloc<GetTripSupplierDetailsEvent, GetTripSupplierDetailsState> {
  final Future<GetTripSupplierDetailsRsp> Function(String suidTrip)
  getTripSupplierDetails;

  GetTripSupplierDetailsBloc({required this.getTripSupplierDetails})
    : super(GetTripSupplierDetailsInitial()) {
    on<FetchTripSupplierDetails>(_onFetchTripSupplierDetails);
  }

  Future<void> _onFetchTripSupplierDetails(
    FetchTripSupplierDetails event,
    Emitter<GetTripSupplierDetailsState> emit,
  ) async {
    emit(GetTripSupplierDetailsLoading());

    try {
      debugPrint('========== GET TRIP SUPPLIER DETAILS ==========');
      debugPrint('Trip ID: ${event.suidTrip}');

      final response = await getTripSupplierDetails(event.suidTrip);

      debugPrint('API Status: ${response.status?.jStatusCode}');
      debugPrint('API Message: ${response.status?.sResponseText}');

      final supplierDetails = response.liSupplierTripDetails ?? [];

      debugPrint('Supplier Details Count: ${supplierDetails.length}');

      for (final supplier in supplierDetails) {
        debugPrint('Supplier Detail ID: ${supplier.suidTripSupplierDetails}');
        debugPrint('Supplier Name: ${supplier.sSupplierName}');
        debugPrint('Supplier ID: ${supplier.suidSupplier}');
        debugPrint('Pickup Status: ${supplier.sSupplierPickupstatus}');
        debugPrint('Pickup: ${supplier.bPickup}');
      }

      debugPrint('===============================================');

      if (response.status?.jStatusCode == 0) {
        emit(
          GetTripSupplierDetailsSuccess(
            response: response,
            supplierDetails: supplierDetails,
          ),
        );
      } else {
        emit(
          GetTripSupplierDetailsFailure(
            message:
                response.status?.sResponseText ??
                'Unable to get trip supplier details.',
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Get Trip Supplier Details Error: $e');
      debugPrint('Stack Trace: $stackTrace');

      emit(GetTripSupplierDetailsFailure(message: e.toString()));
    }
  }
}
